// if we already have an onload function, save that one
var prev_handler = window.onload;

window.onload = function() {
    // call the previous onload function
    if (prev_handler) {
        prev_handler();
    }

    const link = document.createElement("a");
    link.classList.add("p-navigation__link");
    link.text = "Give feedback";
    link.href = (
        github_url
        + "/issues/new?"
        + "title=docs%3A+TYPE+YOUR+QUESTION+HERE"
        + "&body=*Please describe the question or issue you're facing with "
        + `"${document.title}"`
        + ".*"
        + "%0A%0A%0A%0A%0A"
        + "---"
        + "%0A"
        + `*Reported+from%3A+${location.href}*`
    );
    link.target = "_blank";

    const li = document.createElement("li");
    li.append(link)
    li.classList.add("github-issue-link");

    const container = document.querySelector(".p-navigation__links");
    container.append(li);
};
