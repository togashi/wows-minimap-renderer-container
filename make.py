#!/usr/bin/env python3

import os
import sys
import glob
import subprocess
from pathlib import Path

REPLAYDIR = os.getenv('REPLAYDIR', '/replays')

def convert_replay(replay_file):
    """Convert a single replay file to MP4"""
    mp4_file = replay_file.replace('.wowsreplay', '.mp4')
    
    # Skip if MP4 already exists
    if os.path.exists(mp4_file):
        print(f"Skipping {replay_file} (MP4 already exists)", file=sys.stderr)
        return
    
    print(f"Converting {replay_file} to {mp4_file}", file=sys.stderr)
    subprocess.run(['python', '-m', 'render', '--replay', replay_file], check=True)

def pipe_rendered():
    """Output tmp.mp4 content to stdout"""
    tmp_file = os.path.join(REPLAYDIR, 'tmp.mp4')
    if os.path.exists(tmp_file):
        with open(tmp_file, 'rb') as f:
            sys.stdout.buffer.write(f.read())
    else:
        print(f"Error: {tmp_file} not found", file=sys.stderr)
        sys.exit(1)

def create_tmp_from_stdin():
    """Read from stdin and create tmp.wowsreplay"""
    tmp_file = os.path.join(REPLAYDIR, 'tmp.wowsreplay')
    os.makedirs(REPLAYDIR, exist_ok=True)
    with open(tmp_file, 'wb') as f:
        f.write(sys.stdin.buffer.read())

def main():
    """Main entrypoint"""
    if len(sys.argv) < 2:
        # Default: convert all replays
        target = 'all'
    else:
        target = sys.argv[1]
    
    if target == 'pipe':
        create_tmp_from_stdin()
        convert_replay(os.path.join(REPLAYDIR, 'tmp.wowsreplay'))
        pipe_rendered()
    elif target == 'all':
        # Convert all .wowsreplay files
        replay_files = glob.glob(os.path.join(REPLAYDIR, '*.wowsreplay'))
        if not replay_files:
            print(f"No replay files found in {REPLAYDIR}", file=sys.stderr)
            return
        for replay_file in sorted(replay_files):
            if not replay_file.endswith('tmp.wowsreplay'):
                convert_replay(replay_file)
    else:
        print(f"Unknown target: {target}", file=sys.stderr)
        print("Usage: entrypoint.py [all|pipe]", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()
