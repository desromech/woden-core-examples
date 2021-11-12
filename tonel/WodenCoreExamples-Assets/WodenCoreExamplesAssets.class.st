"
I am an utility for locating the Woden Core examples assets.
"
Class {
	#name : #WodenCoreExamplesAssets,
	#superclass : #PhaNAPIIcebergProjectAssets,
	#category : #'WodenCoreExamples-Assets'
}

{ #category : #hooks }
WodenCoreExamplesAssets >> adjustLocation: repoLocation [
	^ repoLocation / 'assets'
]
