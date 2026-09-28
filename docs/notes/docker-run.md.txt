What happens when I type docker run


This command combines 2 commands: create (create a container from an image) and start (start created container)
	create: searched locally for the specified image, if it is not present locally, docker will try to pull it from the docker hub repo
	start: will allocate the needed resources for the process from the kernel and isolate it from the other processes.

An image is made up of read only layers. When we create a container from an image, we are attaching a write layer on top of that image.

This command also sets the initial config of the container. If we require ports to be open, a different PID1 process then the default one or terminal to be attached, we need to specify them. Otherwise, if we forgot to specify a setting, we will need to recreate the container. This means that the container's configuration is immutable once it has been created and it should be treated as a disposable resource that we can recreate as many times as needed. (this does not include the filesystem of the container if present)

Depending on the image, when we run the command we can either have a container/PID1 process that exits immediately after running (as in the case of an ubuntu image where the main default process is just a bash shell) or running indefinitely until the container is stopped.
	Once the container exits, it is not removed, only stopped and it's writable layer is kept. Hence, when we start the container, the same container is brought back.
		
In case of ubuntu, if we attach a terminal to the container (either interactive or remote):
	docker run -it ubuntu bash -> this interactive bash becomes PID1
the container will continue running until that terminal is closed (we type 'exit')

	this is a fundamental principal found in containers: a container lives as long as its PID1 lives.

This command has multiple flags that can be used such as -p for ports, -t for terminal (-it with interactive terminal), -v for adding volumes, -e for environment variables, --rm (remove after running; useful for debugging).

Another useful command is exec on an already running container
	 docker exec -it <container> bash

	however, this bash will not replace the PID1, it will only be a guest process on the container