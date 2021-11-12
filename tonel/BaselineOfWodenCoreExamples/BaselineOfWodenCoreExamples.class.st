Class {
	#name : #BaselineOfWodenCoreExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfWodenCoreExamples
}

{ #category : #baselines }
BaselineOfWodenCoreExamples >> baseline: spec [
    <baseline>
	spec for: #'common' do: [
		spec
			baseline: #'FormProceduralLibrary' with: [ spec repository: 'github://ronsaldo/form-procedural-library' ];
			baseline: #'WodenSceneGraph' with: [ spec repository: 'github://ronsaldo/woden-core-scene-graph' ];	
			baseline: #'WodenGameFramework' with: [ spec repository: 'github://ronsaldo/woden-core-game-framework' ];
			package: #'WodenCoreExamples-Assets' with: [
				spec requires: #( #'WodenSceneGraph' #FormProceduralLibrary).
			];
			package: #'WodenCoreExamples-SceneGraph' with: [
				spec requires: #( #'WodenSceneGraph').
			];
			package: #'WodenCoreExamples-GameFramework' with: [
				spec requires: #( #'WodenGameFramework' ).
			]
	].

]
