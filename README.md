# WODEN Engine Core Heavy Example
This repository contains multiple examples that use the WODEN Engine Core APIs that rely on heavy assets

## Loading in Pharo:

These examples can be loaded in Pharo with by running the following in Playground:

```smalltalk
EpMonitor disableDuring: [
  Author useAuthor: 'Load' during: [
      Metacello new
         baseline: 'WodenCoreExamples';
         repository: 'github://desromech/woden-core-examples';
         onConflictUseIncoming;
         load
   ]
]
```

See the different packages that start with the **WodenCoreExamples-** to check
the different examples.

## Loading in Squeak:

These examples can be loaded in Squeak by using the following script: 

```smalltalk
Metacello new
    baseline: 'WodenCoreExamples';
    repository: 'github://desromech/woden-core-examples';
    onConflictUseIncoming;
    load
```

On Squeak the AbstractGPU library must be installed manually, look for the latest release on https://github.com/desromech/abstract-gpu for find the binary library. Download the release for your platform in a folder that can be found by the Squeak VM, and perform a save and quit of the image.
