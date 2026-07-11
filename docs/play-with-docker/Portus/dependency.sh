#Installing YARN
apt update -y
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list
.d/yarn.list
apt-get update && sudo apt-get install yarn

#Installing NodeJS
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
apt-get update && sudo apt-get install yarn

#Remove cmdtest in case it conflicts with available old YARN
apt remove cmdtest
apt-get update && sudo apt-get install yarn

#Adding Webpack
yarn add global webpack
yarn install
apt add --update nodejs nodejs-npm && npm install npm@latest -g
npm install npm@latest -gyarn add global webpack
yarn add global webpack
npm install webpack -g
apt add --update nodejs nodejs-npm && npm install npm@latest -g
npm install npm@latest -g
npm install webpack -g
webpack --watch --config config/webpack.js
