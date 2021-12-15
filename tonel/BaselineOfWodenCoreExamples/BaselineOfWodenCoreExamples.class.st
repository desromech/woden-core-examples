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
			baseline: #'WodenSceneGraph' with: [ spec repository: 'github://ronsaldo/woden-core-scene-graph' ];	
			baseline: #'WodenGameFramework' with: [ spec repository: 'github://ronsaldo/woden-core-game-framework' ];
			baseline: #'WodenRoassal' with: [ spec repository: 'github://ronsaldo/woden-core-roassal' ];
			baseline: #'WodenEditor' with: [ spec repository: 'github://ronsaldo/woden-core-editor' ];
			package: #'WodenCoreExamples-Assets' with: [
				spec requires: #( #'WodenSceneGraph').
			];
			package: #'WodenCoreExamples-SceneGraph' with: [
				spec requires: #( #'WodenSceneGraph').
			];
			package: #'WodenCoreExamples-GameFramework' with: [
				spec requires: #( #'WodenGameFramework' ).
			]
	].

]
