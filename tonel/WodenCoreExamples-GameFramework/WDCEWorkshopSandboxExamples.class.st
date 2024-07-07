Class {
	#name : 'WDCEWorkshopSandboxExamples',
	#superclass : 'Object',
	#category : 'WodenCoreExamples-GameFramework',
	#package : 'WodenCoreExamples-GameFramework'
}

{ #category : 'examples' }
WDCEWorkshopSandboxExamples class >> exampleWorkshopIsland [
	"
	self exampleWorkshopIsland
	"
	(WDGFWorld withApplicationSettings: WDCEGameFrameworkApplicationSettings)
		loadFromFileNamed: 'maps/workshopIsland.wgfworld';
		playInWindow
]

{ #category : 'examples' }
WDCEWorkshopSandboxExamples class >> exampleWorkshopSandbox [
	"
	self exampleWorkshopSandbox
	"
	(WDGFWorld withApplicationSettings: WDCEGameFrameworkApplicationSettings)
		loadFromFileNamed: 'maps/workshopSandbox.wgfworld';
		playInWindow
]

{ #category : 'see class side' }
WDCEWorkshopSandboxExamples >> seeClassSide [
]
