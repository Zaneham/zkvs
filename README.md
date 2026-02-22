# ZKVS

A database engine written in IBM High Level Assembler.
This is not a joke. Well, it might be. The records go in and come out
and that's really all you can ask of anything.

Keyed storage built from first principles. Sequential I/O up through
B-tree indexing, alternate keys, and crash recovery.

System-agnostic: same source runs on z390, Hercules, and real z/OS.
Platform I/O is behind a macro abstraction layer.

Currently working on this and chipping away at it.

## Status

| Version | What | Status |
|---------|------|--------|
| v0.1 | Sequential fixed-length records | Working |
| v0.2 | Primary key with B-tree index | Next |
| v0.3 | Alternate indexes | Planned |
| v0.4 | Write-ahead log and crash recovery | Planned |

## Structure

```
src/
  macros/           I/O abstraction (ZKVOPEN, ZKVCLOSE, ZKVPUT, ZKVGET)
  ZKVSLOAD.MLC      Writes records
  ZKVSSEQ.MLC       Reads them back

platform/
  z390/             z390 emulator
  Hercules/         Hercules MVS
  Zos/              Real z/OS
```

## Running (z390)

Requires [z390](https://github.com/z390development/z390) and a JDK.

```
cd platform/z390
run.bat load
run.bat read
```

## Licence

Apache 2.0

## Author

Zane Hambly — zanehambly@gmail.com
