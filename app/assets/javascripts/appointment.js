document.getElementById("search_by_date").addEventListener("click", function(){
  var year = document.getElementById('_search_date_1i').value;
  var month = document.getElementById('_search_date_2i').value - 1;
  var day = document.getElementById('_search_date_3i').value;
  const date = new Date(year, month, day);
  const params = date.toLocaleString("en-GB", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  });
  document.getElementById('date').value = params;
});