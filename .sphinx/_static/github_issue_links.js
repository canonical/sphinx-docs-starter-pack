var prev_handler = window.onload;

window.onload = function () {
    // call the previous onload function
    if (prev_handler) {
        prev_handler();
    }

    const linkAttributes = {
        classList: ["muted-link", "github-issue-link"],
        text: "Give feedback",
        href: (
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
        ),
        target: "_blank"
    };

    function createLink(attrs) {
        const link = document.createElement("a");
        attrs.classList.forEach(className => link.classList.add(className));
        link.text = attrs.text;
        link.href = attrs.href;
        link.target = attrs.target;
        return link;
    }

    const mobileLink = createLink(linkAttributes);
    const mobileDiv = document.createElement("div");
    mobileDiv.classList.add("github-issue-link-container");
    mobileDiv.append(mobileLink);

    const mobileContainer = document.querySelector(".article-container > .content-icon-container");
    if (mobileContainer) {
        mobileContainer.prepend(mobileDiv);
    }

    const desktopLink = createLink(linkAttributes);
    desktopLink.classList.add("p-navigation__link");
    const desktopLi = document.createElement("li");
    desktopLi.classList.add("github-issue-link");
    desktopLi.append(desktopLink);

    const desktopContainer = document.querySelector(".p-navigation__links");
    if (desktopContainer) {
        desktopContainer.append(desktopLi);
    }
};
