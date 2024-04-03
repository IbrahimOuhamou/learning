//in the name of Allah
console.log("in the name of Allah");
console.log("la ilaha illa Allah");

//window.alert("la ilaha illa Allah");

let x = "p3";
let bismi_allah = "in the name of Allah";

console.log(bismi_allah);


console.log(document.getElementById("p1").innerHTML);
document.getElementById("p1").innerHTML = "in the name of Allah";
document.getElementById("p2").innerHTML = bismi_allah;
document.getElementById(x).innerHTML = "in the name of Allah";

let bismi_allah_user_var = window.prompt("what text you want?");
document.getElementById("p1").innerHTML = bismi_allah_user_var;
document.getElementById("p2").innerHTML = bismi_allah_user_var;
document.getElementById(x).innerHTML = bismi_allah_user_var;

let bismi_allah_input_html_code = "<input type=\"text\">";

let bismi_allah_user_input;
let bismi_allah_function = function()
{
    bismi_allah_user_input = document.getElementById("user_input").value;
    window.alert(bismi_allah_user_input);
    //bismi_allah_input_html_code += bismi_allah_input_html_code;
    document.getElementById("bismi_allah_form").innerHTML += bismi_allah_input_html_code;
    document.getElementById("user_button").onclick = bismi_allah_function;
}

document.getElementById("user_button").onclick = bismi_allah_function;

