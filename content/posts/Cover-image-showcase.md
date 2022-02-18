---
title: "Tuto Pour les dev Doctothon"
thumbnailImagePosition: left
thumbnailImage: //d1u9biwaxjngwg.cloudfront.net/cover-image-showcase/city-750.jpg
coverImage: /img/docto_duck.png
metaAlignment: center
coverMeta: out
date: 2015-05-13
categories:
- tranquilpeak
- features
tags:
- cover image
---


## Le workflow git

Pour la collaboration de plusieurs ingénieurs de développement, des règles doivent etre convenues

Voyons, par l'exemple.


* Récupérez  le code localment, et commencez une nouvelle tâche :

```bash
export THATSME=$(whoami)
git clone git@github.com:Doctothon/website-dev.git ./doctothon_${THATSME}

cd ./doctothon_${THATSME}
git flow init --defaults
# git checkout develop
git flow feature start ${THATSME}-ma-tache-du-moment
git push -u origin HEAD
git add -A && git commit -m "mj'explique ici ce que j'ai fait comme modif dans le code" && git push -u origin HEAD

```



### ANNEXE A : Github SSH Key

```bash
ssh-keygen -t rsa -b 4096
ls -alh ~/.ssh/
cat ~/.ssh/id_rsa.pub
```
* Add the Public SSH Key to the SSH KEYs of your Github User ('settings' menu)


### ANNEXE B : Hugo Tutorials

Nos cosneils pour un démarrage parfait :

* https://www.youtube.com/watch?v=qtIqKaDlqXo&list=PLLAZ4kZ9dFpOnyRlyS-liKL5ReHDcj4G3
