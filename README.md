# UnderTree base Docker images

This repository contains the build scripts for
the Docker images used during builds of UT modules and implementations.
They are used by the Jenkinsfile of each module or implementation.
For more information, check the documentation of the shared
[Jenkinsfile](https://github.com/softwaregroup-bg/jenkinsfile).

The following base Docker images are available:

- `nexus-dev.softwaregroup.com:5000/softwaregroup/node-gallium` -
  this image is suitable for building low level UT modules, like
  ports, codecs, etc.

  It is based on official Docker image for nodejs version 16, including also
  - git
  - basic build tools
  - global installation of
    [ut-tools](https://www.npmjs.com/package/ut-tools) version 7.

- `nexus-dev.softwaregroup.com:5000/softwaregroup/ut-gallium` -
  this image is suitable for building higher level modules,
  which contain business logic. It includes more dependencies,
  which are often needed by the business logic modules.

  It is based on node-gallium, with these additional packages
  preinstalled:
  - global packages:
    - [ut-help](https://www.npmjs.com/package/ut-help)
    - [ut-webpack](https://www.npmjs.com/package/ut-webpack)
    - [ut-storybook](https://www.npmjs.com/package/ut-storybook)
  - local packages:
    - see [ut/package.json](./ut/package.json) for full list of packages.

- `nexus-dev.softwaregroup.com:5000/softwaregroup/impl-gallium` -
  this image is suitable for building implementations.

  It is based on ut-gallium, with many of the frequently used
  business modules preinstalled. See [impl/package.json](./impl/package.json)
  for full list of packages.

- `nexus-dev.softwaregroup.com:5000/softwaregroup/deploy-gallium` -
  this image is used for building the deployment image. It does not
  contain any build tools, but instead has some third party dependencies
  preinstalled - such as chromium and mssql tools like bcp.

- `nexus-dev.softwaregroup.com:5000/softwaregroup/capture-website` -
  this image is used for capturing screenshots of SonarQube after
  a build.

- `nexus-dev.softwaregroup.com:5000/softwaregroup/localtunnel` -

  This image is still work in progress and is intended to enable
  automated tests that involve webhook calls from external systems.
