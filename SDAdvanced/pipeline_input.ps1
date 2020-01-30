function get-pipelineinput1{

  foreach($item in $input){
    write-host "we got a $item"
  }
}

filter get-pipelineinput2{
    write-host "we got a $_"
}