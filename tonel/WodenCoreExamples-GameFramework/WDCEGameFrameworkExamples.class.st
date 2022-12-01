"
I hold heavy game framework examples.
"
Class {
	#name : #WDCEGameFrameworkExamples,
	#superclass : #Object,
	#category : #'WodenCoreExamples-GameFramework'
}

{ #category : #'example - ibl' }
WDCEGameFrameworkExamples class >> exampleOpaquePool [
	"
	self exampleOpaquePool
	"
	| lightProbe tilesMaterial concreteMaterial waterMaterial borderThickness world poolMesh poolActor waterMesh waterActor lightSourceActor hdriActor |
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	tilesMaterial := WDSceneExamplesProceduralAssets uniqueInstance tileMaterial.
	concreteMaterial := WDMetallicRoughnessMaterial default.
	waterMaterial := WDSceneExamplesProceduralAssets uniqueInstance poolWaterOpaqueMaterial.

	borderThickness := 0.5.
	
	world := WDGFWorld new.
	
	poolMesh := WDMeshBuilder new
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
		mesh.

	poolActor := WDGFActor new.
	poolActor addComponent: (WDGFActorMeshSceneComponent with: poolMesh).
	world spawnActor: poolActor.

	waterMesh := WDMeshBuilder new
		currentMaterial: waterMaterial;
		addPlaneWithWidth: 5 height: 5;
		generateTexcoords0WithFacePlanarTransformWithScale: 1 asVector2;
		generateTangentSpaceFrame;
		mesh.
	waterActor := WDGFActor new.
	waterActor
		addComponent: (WDGFActorMeshSceneComponent with: waterMesh);
		position: (Vector3 x: 0.0 y: -0.3 z: 0.0).
	world spawnActor: waterActor.

	hdriActor := WDGFActor new.
	hdriActor
		addComponent: (WDGFSkyBoxComponent with: lightProbe environment);
		addComponent: (WDGFAmbientLightProbeComponent with: lightProbe).
	world spawnActor: hdriActor.
	
	lightSourceActor := WDGFActor new.
	lightSourceActor
		addComponent: (WDGFActorLightSourceSceneComponent with: (WDDirectionalLightSource new
			color: (Vector3 x: 1.0 y: 1.0 z: 0.8) normalized;
			intensity: 0.7;
			yourself)).
	world spawnActor: lightSourceActor.
	world spawnActor: WDGFActorTemplates noclipCameraActor.
	
	world playInMorphic
]

{ #category : #'example - ibl' }
WDCEGameFrameworkExamples class >> examplePool [
	"
	self examplePool
	"
	| lightProbe tilesMaterial concreteMaterial waterMaterial borderThickness world poolMesh poolActor waterMesh waterActor lightSourceActor hdriActor |
	lightProbe := WDLightProbe forHDRIFileReference: WodenCoreExamplesAssets location / 'hdri' / 'world'/ 'venice_sunset_1k.hdr'.
	tilesMaterial := WDSceneExamplesProceduralAssets uniqueInstance tileMaterial.
	concreteMaterial := WDMetallicRoughnessMaterial default.
	waterMaterial := WDSceneExamplesProceduralAssets uniqueInstance poolWaterMaterial.

	borderThickness := 0.5.
	
	world := WDGFWorld new.
	
	poolMesh := WDMeshBuilder new
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
		mesh.

	poolActor := WDGFActor new.
	poolActor addComponent: (WDGFActorMeshSceneComponent with: poolMesh).
	world spawnActor: poolActor.

	waterMesh := WDMeshBuilder new
		currentMaterial: waterMaterial;
		addPlaneWithWidth: 5 height: 5;
		generateTexcoords0WithFacePlanarTransformWithScale: 1 asVector2;
		generateTangentSpaceFrame;
		mesh.
	waterActor := WDGFActor new.
	waterActor
		addComponent: (WDGFActorMeshSceneComponent with: waterMesh);
		position: (Vector3 x: 0.0 y: -0.3 z: 0.0).
	world spawnActor: waterActor.

	hdriActor := WDGFActor new.
	hdriActor
		addComponent: (WDGFSkyBoxComponent with: lightProbe environment);
		addComponent: (WDGFAmbientLightProbeComponent with: lightProbe).
	world spawnActor: hdriActor.
	
	lightSourceActor := WDGFActor new.
	lightSourceActor
		addComponent: (WDGFActorLightSourceSceneComponent with: (WDDirectionalLightSource new
			color: (Vector3 x: 1.0 y: 1.0 z: 0.8) normalized;
			intensity: 0.7;
			yourself)).
	world spawnActor: lightSourceActor.
	world spawnActor: WDGFActorTemplates noclipCameraActor.
	
	world playInMorphic
]

{ #category : #'see class side' }
WDCEGameFrameworkExamples >> seeClassSide [
]
