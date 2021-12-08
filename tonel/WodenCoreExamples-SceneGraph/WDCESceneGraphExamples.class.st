"
I hold heavy scene graph examples.
"
Class {
	#name : #WDCESceneGraphExamples,
	#superclass : #Object,
	#category : #'WodenCoreExamples-SceneGraph'
}

{ #category : #'example - ibl' }
WDCESceneGraphExamples class >> exampleImageBasedLighting [
	| lightProbe scene baseSphere material |
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	scene := WDScene new
		ambientLighting: 0.0;
		ambientLightProbe: lightProbe;
		addBackground: (WDMeshBuilder new
			currentMaterial: (WDEnvironmentMapMaterial new
				colorTexture: lightProbe environment;
				background: true;
				yourself);
			addInteriorCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
			mesh
		);
		yourself.

	baseSphere := WDMeshBuilder new
		addUVSphereWithDiameter: 2.0 segments: 32 slices: 32;
		mesh.
	0 to: 1 by: 0.1 do: [ :roughnessFactor|
		0 to: 1 by: 0.1 do: [ :metallicFactor|
			material := WDMetallicRoughnessMaterial new
				roughnessFactor: roughnessFactor;
				metallicFactor: metallicFactor;
				yourself.
			
			scene add: ((baseSphere copyWithMaterial: material) asSceneNode
					position: (Vector3 x: roughnessFactor * 30 y: metallicFactor * 30 z: 0) - 15;
					yourself)
		]
	].

	scene inspect
]

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

{ #category : #'example - ibl' }
WDCESceneGraphExamples class >> exampleTiledFloor [
	| lightProbe |
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	WDScene new
		ambientLighting: 0.0;
		ambientLightProbe: lightProbe;
		addBackground: (WDMeshBuilder new
			currentMaterial: (WDEnvironmentMapMaterial new
				colorTexture: lightProbe environment;
				background: true;
				yourself);
			addInteriorCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
			mesh
		);
		add: ((WDMeshBuilder new
			currentMaterial: WDSceneExamplesProceduralAssets uniqueInstance tileMaterial;
			addCubeWithWidth: 5.0 height: 0.1 depth: 5.0;
			generateTexcoords0WithFacePlanarTransformWithScale: 4 asVector2;
			generateTangentSpaceFrame;
			mesh) asSceneNode 
				translateByY: -1.0;
				yourself);
		inspect
]

{ #category : #'see class side' }
WDCESceneGraphExamples >> seeClassSide [
]
