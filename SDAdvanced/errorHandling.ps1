try {
  $x=get-ciminstance -class win32_service -ComputerName mike-she-lap,nosuchcomputer -ErrorVariable Problems -ErrorAction SilentlyContinue 
} catch {
  write-host "something bad happened $_"
}