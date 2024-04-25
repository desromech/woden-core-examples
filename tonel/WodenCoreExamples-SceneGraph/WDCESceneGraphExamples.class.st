"
I hold heavy scene graph examples.
"
Class {
	#name : #WDCESceneGraphExamples,
	#superclass : #Object,
	#category : #'WodenCoreExamples-SceneGraph'
}

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> displayModelWithBasicLighting: modelName [
	| scene lightProbe |
	scene := (WDModelAssetReadWriter readFileNamed: (WodenCoreExamplesAssets location resolve: modelName)) scenes first copy.
	
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	
	scene
		ambientLighting: 0.0;
		ambientLightProbe: lightProbe;
		addBackground: (WDMeshBuilder new
			currentMaterial: (WDEnvironmentMapMaterial new
				colorTexture: lightProbe environment;
				background: true;
				yourself);
			addInteriorCubeWithWidth: 1.0 height: 1.0 depth: 1.0;
			mesh
		).

	scene
		add: ((WDDirectionalLightSource new
				color: (Vector3 x: 1.0 y: 1.0 z: 0.8) normalized;
				intensity: 0.7;
				asSceneNode)
					rotateDegreesOnX: -35;
					translateToX: 0.0 y: 1.5 z: 2.5;
					yourself).

	scene
		openInWindow
]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> displayModelWithBasicLighting: modelName scale: scale animationCycle: animationCycle [
	| scene modelAsset skeletalMesh animation animationBoneMap lightProbe currentTime |
	modelAsset := WDModelAssetReadWriter readFileNamed: (WodenCoreExamplesAssets location resolve: modelName).
	
	skeletalMesh := modelAsset skeletalMeshes first copy.
	skeletalMesh currentPose: skeletalMesh skeleton restPose.

	animation := modelAsset elementNamed: animationCycle.
	animationBoneMap := animation makeBoneMapForSkeleton: skeletalMesh skeleton.

	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	
	scene := WDScene new.
	scene
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
		add: (skeletalMesh asSceneNode scale: 0.018).

	scene
		add: ((WDDirectionalLightSource new
				color: (Vector3 x: 1.0 y: 1.0 z: 0.8) normalized;
				intensity: 0.7;
				asSceneNode)
					rotateDegreesOnX: -35;
					translateToX: 0.0 y: 1.5 z: 2.5;
					yourself).
	
	currentTime := 0.0.
	scene updateBlock: [ :delta |
		currentTime := currentTime + delta.
		skeletalMesh currentPose setForRestPose.
		
		animation applyPosition: currentTime looped: true toSkeletonPose: skeletalMesh currentPose withBoneMap: animationBoneMap.
		true
	].
	
	scene
		openInWindow
]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleAsyncModelLoading [
	"
	self exampleAsyncModelLoading
	"
	| asyncContext |
	asyncContext := WDFileAsyncContentContext workingDirectory: WodenCoreExamplesAssets location.
	WDScene new
		add: (WDAsyncSceneNode new
			scale: 0.018;
			uri: 'models/Fox/Fox.gltf';
			asyncContext: asyncContext;
			yourself);
		add: (WDAsyncSceneNode new
			translateByX: 2;
			uri: 'models/DamagedHelmet/DamagedHelmet.glb';
			asyncContext: asyncContext;
			yourself);
		updateBlock: [ :delta | true ];
		openInWindow
]

{ #category : #'example - ibl' }
WDCESceneGraphExamples class >> exampleImageBasedLighting [
	"
	self exampleImageBasedLighting
	"
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

	scene openInWindow
]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleModelAnimatedFox [
	"
	self exampleModelAnimatedFox
	"
	self displayModelWithBasicLighting: 'models/Fox/Fox.gltf' scale: 0.018 animationCycle: 'Survey'

]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleModelDamagedHelmet [
	"
	self exampleModelDamagedHelmet
	"
	self displayModelWithBasicLighting: 'models/DamagedHelmet/DamagedHelmet.glb'
]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleModelFox [
	"
	self exampleModelFox
	"
	self displayModelWithBasicLighting: 'models/Fox/Fox.gltf'
]

{ #category : #'examples - models' }
WDCESceneGraphExamples class >> exampleModelSponza [
	"
	self exampleModelSponza
	"
	self displayModelWithBasicLighting: 'models/Sponza/glTF/Sponza.gltf'
]

{ #category : #'example - ibl' }
WDCESceneGraphExamples class >> exampleOpaquePool [
	"
	self examplePool
	"
	| lightProbe tilesMaterial concreteMaterial waterMaterial borderThickness |
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	tilesMaterial := WDSceneExamplesProceduralAssets uniqueInstance tileMaterial.
	concreteMaterial := WDMetallicRoughnessMaterial default.
	waterMaterial := WDSceneExamplesProceduralAssets uniqueInstance poolWaterOpaqueMaterial.

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
			color: (Vector3 x: 1.0 y: 1.0 z: 0.8) normalized;
			intensity: 0.7;
			asSceneNode)
				rotateDegreesOnX: -35;
				translateToX: 0.0 y: 1.5 z: 2.5;
				yourself);
		openInWindow
]

{ #category : #'example - ibl' }
WDCESceneGraphExamples class >> examplePool [
	"
	self examplePool
	"
	| lightProbe tilesMaterial concreteMaterial waterMaterial borderThickness |
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	tilesMaterial := WDSceneExamplesProceduralAssets uniqueInstance tileMaterial.
	concreteMaterial := WDMetallicRoughnessMaterial default.
	waterMaterial := WDSceneExamplesProceduralAssets uniqueInstance poolWaterMaterial.

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
			color: (Vector3 x: 1.0 y: 1.0 z: 0.8) normalized;
			intensity: 0.7;
			asSceneNode)
				rotateDegreesOnX: -35;
				translateToX: 0.0 y: 1.5 z: 2.5;
				yourself);
		openInWindow
]

{ #category : #'example - ibl' }
WDCESceneGraphExamples class >> exampleTiledFloor [
	"
	self exampleTiledFloor
	"
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
		openInWindow
]

{ #category : #'see class side' }
WDCESceneGraphExamples >> seeClassSide [
]
