Git tags vs Docker tags vs Container App revisions

Git tag: a pointer to an existent commit; useful for versioning (points to previous working versions of the code) and tracking (points to the commits from which the code was written). It should never move as it points to a moment in time for the code stored on git and it is also it's own object (when using annotated tags) which store the author, the date and the commit. For lightweight tags, these are just pointers to the commit, with no other information about it as it is not an object

Docker tag: a pointer to a certain image version. It can move and it servers different purposes such as tracking and versioning. Building and pushing again with the same tag moves it to the new image with no warning. The only image identifier that can't move is the digest (sha256:...)
For pushing to the right registry, we need the following format for the name of the image: 
    <registry>/<repository>:<tag>

otherwise, Docker takes by default DockerHub

Container App revision: is an immutable snapshot of the app’s configuration: the image, environment variables, scale settings, and so on; revisions are used for tracking and rollback as well as testing. For deployment mode, if we choose Single, we can only have one active revision which serves 100% of the traffic for that app. For Multiple mode, we can have multiple revisions serving the same app but with different traffic percentage, useful for new updates or rollbacks because we have more control (ex: we can just increase the traffic to the correct version after the tests succeed and silently retire the old revision)

Traceability chain: which code runs in production

Live app → which revision is active?
Revision → which image does it run? (registry, repository, and tag)
Image tag → which git tag?
Git tag → which commit? (git rev-parse "vX.Y.Z^{commit}")
Commit → the code