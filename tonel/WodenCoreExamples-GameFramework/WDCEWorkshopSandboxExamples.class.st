Class {
	#name : #WDCEWorkshopSandboxExamples,
	#superclass : #Object,
	#category : #'WodenCoreExamples-GameFramework'
}

{ #category : #examples }
WDCEWorkshopSandboxExamples class >> exampleWorkshopSandbox [
	"
	self exampleWorkshopSandbox
	"
	(WDGFWorld withApplicationSettings: WDCEGameFrameworkApplicationSettings)
		loadFromFileNamed: 'maps/workshopSandbox.wgfworld';
		playInWindow
]

{ #category : #'see class side' }
WDCEWorkshopSandboxExamples >> seeClassSide [
]
