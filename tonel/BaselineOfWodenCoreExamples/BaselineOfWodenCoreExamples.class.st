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
			baseline: #'WodenSceneGraph' with: [ spec repository: 'github://desromech/woden-core-scene-graph' ];	
			baseline: #'WodenGameFramework' with: [ spec repository: 'github://desromech/woden-core-game-framework' ];
			baseline: #'WodenRoassal' with: [ spec repository: 'github://desromech/woden-core-roassal' ];
			baseline: #'WodenCorePhysics' with: [ spec repository: 'github://desromech/woden-core-physics' ];
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

	spec for: #pharo do: [
		spec
			baseline: #'WodenEditor' with: [ spec repository: 'github://desromech/woden-core-editor' ]
	].

]
