Class {
	#name : #WDCEGameFrameworkApplicationSettings,
	#superclass : #WDGFApplicationSettings,
	#category : #'WodenCoreExamples-GameFramework'
}

{ #category : #'accessing - ui' }
WDCEGameFrameworkApplicationSettings >> assetsLocations [
	^ { WodenCoreExamplesAssets location }
]

{ #category : #'accessing - ui' }
WDCEGameFrameworkApplicationSettings >> projectLocation [
	^ WodenCoreExamplesAssets location parent
]
