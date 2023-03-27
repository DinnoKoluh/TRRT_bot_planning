Changelog geom3d

Changelog for the geom3d package distributed on Mathworks FileExchange.
The "geom3d" package corresponds to the modules "geom3d" and "meshes3d" from
the MatGeom Project, available at https://github.com/mattools/matGeom

Tries to follow semantic versioning.


## Release 1.23 - 2018-07-26

### Added
- add meshes3d/meshFaceAreas.m
- add geom3d/isTransform3d.m (thanks to Oqilipo)

### Changed
- updated return type of several drawing functions

### Fixed
- fixed bug in orientedBox3d


## Release 1.22 - 2018-06-07

### Added 

- added several functions fore reading/writing 3D meshes in PLY and OFF formats
- added distancePointMesh function
- added distPointTriangle3d
- added isPointInMesh
- added clipEdge3d
- added edgeToLine3d conversion function
- added some files from geom2d in private directories to prevent missing file errors

### Changed

- createScaling3d can now specifiy center of scaling
- removed some deprecated files
- added axes handle input for drawPoint3d.m
- much faster centroid calculation for the 3D triangle mesh case
- added a 'trimMesh' option to clipMeshVertices
- unification of the parsing of some mesh functions
- checkMeshAdjacentFaces.m: compute edge array if it is not specified
- several updates in function headers
