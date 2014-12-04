#!/bin/sh
/usr/bin/screen -S tunnel ssh -L 3334:localhost:3334 -L 3333:localhost:3333 -L 3335:localhost:3335 -L 3336:localhost:3336 -L 3337:localhost:3337 -L 3338:localhost:3338 missoula.org 
