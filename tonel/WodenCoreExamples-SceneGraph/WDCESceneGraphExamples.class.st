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
WDCESceneGraphExamples class >> examplePool [
	| lightProbe tilesMaterial concreteMaterial waterMaterial borderThickness |
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	tilesMaterial := WDSceneExamplesProceduralAssets uniqueInstance tileMaterial.
	concreteMaterial := WDMetallicRoughnessMaterial new.
	waterMaterial := WDSceneExamplesProceduralAssets uniqueInstance poolWaterMaterial copy 
		texcoordOffsetVelocity: (Vector2 y: 1);
		yourself.

	borderThickness := 0.5.

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
		add:(WDMeshBuilder new
			currentMaterial: tilesMaterial;

			translateToX: (borderThickness*0.5) negated - 4.5 y: -1.0 z: 0.0;
			addCubeWithWidth: 4.0 - borderThickness height: 2.0 depth: 5.0 + (borderThickness*2.0);
		
			translateToX: (borderThickness*0.5)+ 4.5 y: -1.0 z: 0.0;
			addCubeWithWidth: 4.0 - borderThickness height: 2.0 depth: 5.0 + (borderThickness*2.0);
		
			translateToX: 0.0 y: -1.0 z: borderThickness + 4.5;
			addCubeWithWidth: 13.0 height: 2.0 depth: 4.0;
		
			translateToX: 0.0 y: -1.0 z: borderThickness negated - 4.5;
			addCubeWithWidth: 13.0 height: 2.0 depth: 4.0;

			"Bottom"
			currentMaterial: concreteMaterial;
			translateToX: 0.0 y: -2.05 z: 0.0;
			addCubeWithWidth: 5.0 height: 0.1 depth: 5.0;

			"Border"
			translateToX: -2.5 - (borderThickness*0.5) y: -1.0 z: 0.0;
			addCubeWithWidth: borderThickness height: 2.2 depth: 5.0 + (borderThickness*2.0);
		
			translateToX: 2.5 + (borderThickness*0.5) y: -1.0 z: 0.0;
			addCubeWithWidth: borderThickness height: 2.2 depth: 5.0 + (borderThickness*2.0);
		
			translateToX: 0.0 y: -1.0 z: 2.5 + (borderThickness*0.5);
			addCubeWithWidth: 5.0 height: 2.2 depth: borderThickness;
		
			translateToX: 0.0 y: -1.0 z: -2.5 - (borderThickness*0.5);
			addCubeWithWidth: 5.0 height: 2.2 depth: borderThickness;
			
			generateTexcoords0WithFacePlanarTransformWithScale: 4 asVector2;
			generateTangentSpaceFrame;
			mesh);
		add: ((WDMeshBuilder new
			currentMaterial: waterMaterial;
			addPlaneWithWidth: 5 height: 5;
			generateTexcoords0WithFacePlanarTransformWithScale: 1 asVector2;
			generateTangentSpaceFrame;
			mesh
		) asSceneNode
			translateToX: 0.0 y: -0.3 z: 0.0;
			yourself);
		add: ((WDDirectionalLightSource new
			intensity: (Vector3 x: 1.0 y: 1.0 z: 0.8) normalized * 0.7;
			asSceneNode)
				rotateDegreesOnX: -35;
				translateToX: 0.0 y: 1.5 z: 2.5;
				yourself);
		inspect
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
