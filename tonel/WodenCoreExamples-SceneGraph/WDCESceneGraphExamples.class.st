"
I hold heavy scene graph examples.
"
Class {
	#name : #WDCESceneGraphExamples,
	#superclass : #Object,
	#category : #'WodenCoreExamples-SceneGraph'
}

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleModelDamagedHelmet [
	(WDModelAssetReadWriter readFileNamed: (WodenCoreExamplesAssets location resolve: 'models/DamagedHelmet/DamagedHelmet.glb')) scenes first inspect
]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleModelFox [
	(WDModelAssetReadWriter readFileNamed: (WodenCoreExamplesAssets location resolve: 'models/Fox/Fox.gltf')) scenes first inspect
]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleModelSponza [
	(WDModelAssetReadWriter readFileNamed: (WodenCoreExamplesAssets location resolve: 'models/Sponza/glTF/Sponza.gltf')) scenes first inspect
]

{ #category : #'see class side' }
WDCESceneGraphExamples >> seeClassSide [
]
