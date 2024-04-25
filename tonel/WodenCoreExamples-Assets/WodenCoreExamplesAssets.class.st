"
I am an utility for locating the Woden Core examples assets.
"
Class {
	#name : #WodenCoreExamplesAssets,
	#superclass : #PhaNAPIGitProjectAssets,
	#category : #'WodenCoreExamples-Assets'
}

{ #category : #hooks }
WodenCoreExamplesAssets class >> adjustLocation: repoLocation [
	^ repoLocation / 'assets'
]

{ #category : #hooks }
WodenCoreExamplesAssets class >> defaultGithubRepositoryName [
	^ 'woden-core-examples'
]

{ #category : #hooks }
WodenCoreExamplesAssets class >> defaultGithubRepositoryOwners [
	^ #(desromech)
]

{ #category : #hooks }
WodenCoreExamplesAssets class >> defaultRepositoryBranch [
	^ 'master'
]
