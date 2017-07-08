# Delphi Unit Dependency Scanner
The Delphi Unit Dependency Scanner (or DUDS as it has become known) parses a Delphi project or group project and builds a unit file hierarchy. The hierarchy can be displayed in several different ways, searched and sorted. It is also possible to rename units using regex expressions.

The unit relationships can be exported in several formats - XML, Gephi CSV and GraphML.

# History
The code was originally hacked together in order to refactor the pretty significant code base of our Easy-IP Network Management product. When the Delphi Developer Group on Google+ (https://plus.google.com/communities/103113685381486591754) started I thought it might be nice to give something back. I released DUDS as freeware and it seemed to go down pretty well.

Over the years I have many requests to open source the code. Unfortunately, it had a lot of dependencies on the main Easy-IP codebase so it was not a simple task. I finally managed to find some time to refactor the code and tidy things up a little in order to release the code. It's still not great and a bit hacky, but it works and I don't have time to make any more improvements. It would be great if somebody else wants to take the batton and improve DUDS in the future.

# Requirements
DUDS is built with Delphi Tokyo, but will proabably compile with all compilers after Delphi 2010. The following 3rd party libraries are required - they can be installed via GetIt.
* VirtualTreeView
* SynEdit

Cheers, 
Paul.
