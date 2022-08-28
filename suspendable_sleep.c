 #include <time.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>

void sigfunc(int sig_no) {return;}

int main(int narg, char** argv)
{
	if(narg != 2) return 1;

	struct sigaction sa = {0};
	sa.sa_handler = &sigfunc;
	sigaction (SIGINT, &sa, NULL);

	struct timespec t, t_rem;
	t.tv_sec = atoi(argv[1]);
	t.tv_nsec = 0;
	while(nanosleep(&t, &t) == -1 && errno == EINTR)
		raise(SIGTSTP);
	return 0;
}
