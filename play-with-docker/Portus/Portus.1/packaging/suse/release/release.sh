#!/bin/bash
set -ex
cd $(dirname $0)

usage_and_exit() {
  echo "usage $0 X.Y.Z"
  echo "Where X.Y.Z is the new release number"
  exit -1
}

if [ $# != 1 ];then
  usage_and_exit
fi
if [ $1 == "help" ];then
  usage_and_exit
fi
if [ $1 == "-h" ];then
  usage_and_exit
fi
if [[ ! "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+(rc[0-9]+)?$ ]];then
 usage_and_exit
fi 

RELEASE=$1
VERSION_2D=$(echo $RELEASE | rev | cut -d. -f1 --complement | rev)
BRANCH="v$VERSION_2D"
ORIG_PROJECT=Virtualization:containers:Portus
DEST_PROJECT=$ORIG_PROJECT:$VERSION_2D
API=https://api.opensuse.org
OSC="osc -A $API"
PKG_DIR=/tmp/$0/$RANDOM

create_subproject() {
  prj_exists=true
  $OSC ls $DEST_PROJECT || prj_exists=false
  if $prj_exists;then
    echo "Project $DEST_PROJECT already exists."
    return
  fi

  echo "Setting version $VERSION_2D in project config template"
  sed -e "s/__VERSION__/$VERSION_2D/g" project.xml.template > project.xml

  echo "Creating new subproject $DEST_PROJECT"
  $OSC meta prj $DEST_PROJECT --file=project.xml

  echo "Copying packages to the new project"
  for package in $($OSC ls $ORIG_PROJECT );do $OSC copypac -e $ORIG_PROJECT $package $DEST_PROJECT; done
}

update_package() {
  echo "Checking out portus package"
  pushd $PKG_DIR
  $OSC checkout $DEST_PROJECT portus

  echo "Setting version in _service file"
  cd $DEST_PROJECT/portus
  cp _service _service.orig
  sed -e "s|/SUSE/Portus/archive/.*.tar.gz|/SUSE/Portus/archive/$RELEASE.tar.gz|g" -i _service
  if [ $? -eq 0 ];then
    echo "WARNING: _service file has not been changed"
  fi

  cp _service _service.orig
  echo "Disabling service"
  sed -e "s/<service name=\"download_url\">/<service name=\"download_url\" mode=\"disabled\">/g" -i _service
  if [ $? -eq 0 ];then
    echo "WARNING: _service file has not been changed"
  fi

  echo "Remove previous tarballs"
  $OSC rm $(ls *.tar.gz) || echo "No previous tarball."
  echo "Getting tarball"
  $OSC service disabledrun

  echo "Add new tarball"
  $OSC add $RELEASE.tar.gz

  echo "Generate spec file"
  tar zxvf $RELEASE.tar.gz
  cd Portus-$RELEASE/packaging/suse
  TRAVIS_COMMIT=$RELEASE TRAVIS_BRANCH=$BRANCH ./make_spec.sh portus
  cd -
  cp Portus-$RELEASE/packaging/suse/portus.spec portus.spec

  echo "Setting version $RELEASE in spec file"
  # We set the BRANCH to the RELEASE tag
  sed -e "s/%define branch $BRANCH/%define branch $RELEASE/g" -i portus.spec
  # We set the Version to the RELEASE tag
  sed -e "s/Version: .*/Version:        $RELEASE/g" -i portus.spec
  echo "Fix source filename because when releasing we are using a disabled service"
  echo "which cause the tarball be named differently"
  sed -e "s/Source:.*Portus-%{branch}.tar.gz/Source:        %{branch}.tar.gz/g" -i portus.spec
  popd
}

commit_all() {
  pushd $PKG_DIR
  cd $DEST_PROJECT/portus
  echo "Commiting new project"
  $OSC commit -m "set release to $RELEASE"
  popd
}

clean() {
  echo "Cleaning..."
  rm -rf $PKG_DIR
}

mkdir -p $PKG_DIR
create_subproject
update_package
commit_all
clean



