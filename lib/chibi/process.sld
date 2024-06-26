
(define-library (chibi process)
  (export exit emergency-exit sleep alarm
          %fork fork kill execute waitpid system system?
          process-command-line process-running?
          set-signal-action! make-signal-set
          signal-set? signal-set-contains?
          signal-set-fill! signal-set-add! signal-set-delete!
          current-signal-mask current-process-id parent-process-id
          signal-mask-block! signal-mask-unblock! signal-mask-set!
          signal/hang-up    signal/interrupt   signal/quit
          signal/illegal    signal/abort       signal/fpe
          signal/kill       signal/segv        signal/pipe
          signal/alarm      signal/term        signal/user1
          signal/user2      signal/child       signal/continue
          signal/stop       signal/tty-stop    signal/tty-input
          signal/tty-output wait/no-hang
          call-with-process-io process->bytevector
          process->string process->sexp process->string-list
          process->output+error process->output+error+status)
  (import (chibi) (chibi io) (chibi string) (chibi filesystem) (only (scheme base) call/cc))
  (cond-expand (threads (import (srfi 18) (srfi 151))) (else #f))
  (cond-expand ((not windows) (include-shared "process")))
  (include "process.scm"))
