;
; A function to escape characters like & for use in URLs.
;
uriEncode(str) {
    f = %A_FormatInteger%
    SetFormat, Integer, Hex
    If RegExMatch(str, "^\w+:/{0,2}", pr)
        StringTrimLeft, str, str, StrLen(pr)
    StringReplace, str, str, `%, `%25, All
    Loop
        If RegExMatch(str, "i)[^\w\.~%/:]", char)
          StringReplace, str, str, %char%, % "%" . SubStr(Asc(char),3), All
        Else Break
    SetFormat, Integer, %f%
    Return, pr . str
}
;
; Returns an array with duplicate items removed
;
unique(nameArray)
{
  hash := {}
  for i, name in nameArray
    hash[name] := null

  trimmedArray := []
  for name, dummy in hash
    trimmedArray.Insert(name)

  return trimmedArray
}