# The Doctothon's Website

This repository version controls the code source of the https://dev.doctothon.org website

## How to build and run locally

### B.O.M.

* [`hugo`](https://gohugo.io/getting-started/quick-start/#step-1-install-hugo) Headless CMS.
* [`nodejs / npm`](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
* [`Golang`](https://go.dev/doc/install) : The Golang programming language SDK

```bash
node -v
npm --version
export PATH=$PATH:/usr/local/go/bin
go version
hugo version
```

* On `MacOS X` :

```bash
bash-3.2$ node -v
v14.15.0
bash-3.2$ npm --version
6.14.8
bash-3.2$ export PATH=$PATH:/usr/local/go/bin
bash-3.2$ go version
go version go1.16.3 darwin/amd64
bash-3.2$ hugo version
Hugo Static Site Generator v0.78.2-959724F0 darwin/amd64 BuildDate: 2020-11-13T10:07:09Z
bash-3.2$ docker version
Client:
 Cloud integration: 1.0.17
 Version:           20.10.7
 API version:       1.41
 Go version:        go1.16.4
 Git commit:        f0df350
 Built:             Wed Jun  2 11:56:22 2021
 OS/Arch:           darwin/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.7
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       b0f5bc3
  Built:            Wed Jun  2 11:54:58 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.6
  GitCommit:        d71fcd7d8303cbf684402823e425e9dd2e99285d
 runc:
  Version:          1.0.0-rc95
  GitCommit:        b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
bash-3.2$ docker-compose version
Docker Compose version 2.2.3
bash-3.2$ git version
git version 2.24.3 (Apple Git-128)
bash-3.2$ git flow version
1.12.3 (AVH Edition)
```

* On GNU/Linux :

```bash
$ node -v
v16.13.0
$ npm --version
8.2.0
$ export PATH=$PATH:/usr/local/go/bin
$ go version
go version go1.17.4 linux/amd64
$ hugo version
hugo v0.89.4-AB01BA6E+extended linux/amd64 BuildDate=.20211207.084017 VendorInfo=gohugo.doctothon.io
$ docker version
Client: Docker Engine - Community
 Version:           19.03.6
 API version:       1.40
 Go version:        go1.12.16
 Git commit:        369ce74a3c
 Built:             Thu Feb 13 01:27:59 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.6
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.16
  Git commit:       369ce74a3c
  Built:            Thu Feb 13 01:26:33 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.12
  GitCommit:        35bd7a5f69c13e1563af8a93431411cd9ecf5021
 runc:
  Version:          1.0.0-rc10
  GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683

```

### Build n Run Locally

* To first resolve all projects dependencies, in one command :

```bash
npm run preps:all
```

* To build the `hugo` projects (the entire generated website ends up in the `./public`) projects dependencies, in one command :

```bash
# build in dev mode
npm run build:dev

# build in production mode
# npm run build:prod
```

* Then start the hugo server in watch mode :

```bash
export DESIRED_VERSION=0.0.0
git clone git@github.com:doctothonio/static-websites-orb.git ~/docto.work
cd ~/docto.work

git checkout ${DESIRED_VERSION}

# npm run spawn
# and then run :

export HUGO_HOST="127.0.0.1"
export HUGO_PORT="4549"
npm start

# you could also execute :
# export PATH=$PATH:/usr/local/go/bin && go version
# hugo serve -b http://${HUGO_HOST}:${HUGO_PORT} -p ${HUGO_PORT} --bind ${HUGO_HOST} -w

##
```

## How to re-generate this project

To see how this website looked when it started, and was automatically generated :

* Execute :

```bash
export DESIRED_VERSION=master
git clone git@github.com:doctothonio/static-websites-orb.git ~/docto.work
cd ~/docto.work
git checkout ${DESIRED_VERSION}

npm preps:all
npm run clean:project && npm run spawn:project
```

* Then run locally your new website :

```bash
export PATH=$PATH:/usr/local/go/bin
hugo serve -b http://127.0.0.1:5445 -p 5445 --bind 127.0.0.1 -w

# or try :
export PATH=$PATH:/usr/local/go/bin
export HUGO_HOST=127.0.0.1
export HUGO_PORT=4547
export HUGO_BASE_URL=http://127.0.0.1:5445
export HUGO_BASE_URL=http://${HUGO_HOST}:${HUGO_PORT}

gulp hugo
gulp serve
```


## How to release

* Release :

```bash
git clone git@github.com:doctothonio/static-websites-orb.git ~/yellowradio.release.work
cd ~/yellowradio.release.work
git checkout master
git flow init --defaults

export RELEASE_VERSION=0.0.54
export DEPLOYMENT_DOMAIN=doctothon.com
export DEPLOYMENT_BASE_URL=https://${DEPLOYMENT_DOMAIN}

git flow release start ${RELEASE_VERSION}

npm run preps:all

if [ -d ./docs ]; then
  rm -fr ./docs
fi;

if [ -d ./public ]; then
  rm -fr ./public
fi;

mkdir -p  ./docs
mkdir -p  ./public

oldHugoBuild () {
  export PATH=$PATH:/usr/local/go/bin
  hugo -b ${DEPLOYMENT_BASE_URL}
  cp -fr ./public/* ./docs/
}
gulpBuild (){
  export PATH=$PATH:/usr/local/go/bin
  export HUGO_HOST=${DEPLOYMENT_DOMAIN}
  export HUGO_PORT=4547
  export HUGO_BASE_URL=http://127.0.0.1:5445
  export HUGO_BASE_URL=http://${HUGO_HOST}:${HUGO_PORT}
  export HUGO_BASE_URL=https://doctothon.com

  gulp hugo
  cp -fr ./public/* ./docs/
}

gulpBuild

cp -fr ./public/* ./docs/

echo "${DEPLOYMENT_DOMAIN}" > CNAME
echo "${DEPLOYMENT_DOMAIN}" > ./docs/CNAME

git add -A && git commit -m "[${RELEASE_VERSION}] - release and deployment" && git push -u origin HEAD

# git flow release finish ${RELEASE_VERSION} && git push -u origin --all  && git push -u origin --tags
git flow release finish -s ${RELEASE_VERSION} && git push -u origin --all  && git push -u origin --tags

```




## surge


```bash

export DEPLOYMENT_DOMAIN=doctothon-$RANDOM.surge.sh
export DEPLOYMENT_BASE_URL=https://${DEPLOYMENT_DOMAIN}

if [ -d ./docs ]; then
  rm -fr ./docs
fi;

if [ -d ./public ]; then
  rm -fr ./public
fi;

mkdir -p  ./docs
mkdir -p  ./public

oldHugoBuild () {
  export PATH=$PATH:/usr/local/go/bin
  hugo -b ${DEPLOYMENT_BASE_URL}

  cp -fr ./public/* ./docs/
}
gulpBuild (){
  export PATH=$PATH:/usr/local/go/bin
  export HUGO_HOST=127.0.0.1
  export HUGO_PORT=4547
  export HUGO_BASE_URL=http://127.0.0.1:5445
  export HUGO_BASE_URL=http://${HUGO_HOST}:${HUGO_PORT}

  gulp hugo
  cp -fr ./public/* ./docs/
}

oldHugoBuild

surge ./public "${DEPLOYMENT_DOMAIN}"

echo "DEPLOYMENT_BASE_URL=[${DEPLOYMENT_BASE_URL}]"




```

```bash
export DEPLOYMENT_DOMAIN=doctothon.surge.sh
export DEPLOYMENT_BASE_URL=https://${DEPLOYMENT_DOMAIN}

if [ -d ./docs ]; then
  rm -fr ./docs
fi;

if [ -d ./public ]; then
  rm -fr ./public
fi;

mkdir -p  ./docs
mkdir -p  ./public

export PATH=$PATH:/usr/local/go/bin
hugo -b ${DEPLOYMENT_BASE_URL}

cp -fr ./public/* ./docs/

surge ./public "${DEPLOYMENT_DOMAIN}"

```

## Env


```bash
export HUGO_BASE_URL=https://127.0.0.1:5447
export HUGO_PORT=5447
gulp hugo

```

## Refs

* https://www.npmjs.com/package/gulp-beautify
* https://www.npmjs.com/package/gulp-seo
* https://www.npmjs.com/package/gulp-newer
* You are my hero :
  * https://tutorialmeta.com/question/instead-change-the-require-of-index-js-to-a-dynamic-import-which-is-available , for solving my gulp issue qith `gulp-imagemin` npm package
