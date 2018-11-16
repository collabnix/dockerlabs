import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_package(host):
    if host.system_info.distribution == 'centos':
        pkg = ["python", "python2-pip"]
    else:
        pkg = ["python", "python-pip"]

    assert host.package(pkg).is_installed
