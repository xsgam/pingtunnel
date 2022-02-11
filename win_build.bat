@echo on


mkdir release

SET OUTPATH=./release/
SET OUTNAME=%1
SET CGO_ENABLED=0
SET LDFLAGS=-w -s

rem default output
IF "%1" == "" (SET OUTNAME=ptun)

SET GOOS=linux
SET GOARCH=386
echo build %GOOS%_%GOARCH%
go build -o %OUTPATH%%OUTNAME%_%GOOS%_%GOARCH% -ldflags "%LDFLAGS%"

SET GOOS=linux
SET GOARCH=amd64
echo build %GOOS%_%GOARCH%
go build -o %OUTPATH%%OUTNAME%_%GOOS%_%GOARCH% -ldflags "%LDFLAGS%"


SET GOOS=windows
SET GOARCH=386
echo build %GOOS%_%GOARCH%
go build -o %OUTPATH%%OUTNAME%_%GOOS%_%GOARCH%.exe -ldflags "%LDFLAGS%"

SET GOOS=windows
SET GOARCH=amd64
echo build %GOOS%_%GOARCH%
go build -o %OUTPATH%%OUTNAME%_%GOOS%_%GOARCH%.exe -ldflags "%LDFLAGS%"

