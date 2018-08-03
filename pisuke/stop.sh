#!/bin/bash

pid=`pgrep -f 'pisuke' `
kill ${pid}
