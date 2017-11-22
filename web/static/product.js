function hideAll() {
  var element = document.getElementsByClassName('tabcontent');
  for (var i = 0; i < element.length; i++) {
    element[i].style.display = 'none';
  }
}

function showElement(elem) {
  hideAll();

  document.getElementById(elem).style.display = 'block';
}

function findButtons() {
    var container = document.getElementsByClassName('table');
    var tabs = container[0].getElementsByTagName('button');
    for(var i = 0; i < tabs.length; i++){
        tabs[i].className = 'inactivetab';
    }
}

function highlight(tab) {
    findButtons();
    tab.className = 'activetab';
}