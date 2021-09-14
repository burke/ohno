/*******************************************************************************
 *
 * This snippet is just some test code as a demo. Nothing special to see here.
 * Add or change code as needed for your own learning / testing.
 *
 ******************************************************************************/

#define _GNU_SOURCE

#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "libptrace_do.h"

#define BUFF_LEN	50
#define CLONE_NEWNET 0x40000000

int main(int argc, char **argv){
	int retval;
	int pid;

	char *string1, *string2, *string3;
	void *tmp_addr;

	struct ptrace_do *target;


	if(argc != 2){
		fprintf(stderr, "usage: %s PID\n", program_invocation_short_name);
		exit(-1);
	}

	// grab the pid of a target process.
	retval = strtol(argv[1], NULL, 10);
	if(errno || !retval){
		fprintf(stderr, "usage: %s PID\n", program_invocation_short_name);
		exit(-1);
	}
	pid = retval;

	pid_t ns_pid = getpid();

	target = ptrace_do_init(pid);

	int pidfd = ptrace_do_syscall(target, __NR_pidfd_open, ns_pid, 0, 0, 0, 0, 0);
	int ret = ptrace_do_syscall(target, __NR_setns, pidfd, CLONE_NEWNET, 0, 0, 0, 0);
	int ret2 = ptrace_do_syscall(target, __NR_close, pidfd, 0, 0, 0, 0, 0);

	ptrace_do_cleanup(target);

	return(0);
}
