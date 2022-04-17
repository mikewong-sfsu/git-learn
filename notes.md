# Database Refactoring for Multiple versions

Version - A major, stand-alone instance of the HVFQI or related questionnaires
Revision - A minor, dependent instance

Functional requirements
- Versioning based on content (e.g. SHA1 hash)
- Ability to create minor revisions of a version
- Ability to promote a minor revision to a version
- Ability to demote a major version to a revision
- Ability to deprecate a version or revision (hide, but not delete)

## Tables

questionnaire
- id: string (SHA1 hash)
- created:datetime
- language:string (2-letter language code)
- parent:string|null (id)
- questions:string (json)
- responses:string (json)
- strategies:string (json)

The latest version is the end of the chain.

Algorithm - load all versions






##
