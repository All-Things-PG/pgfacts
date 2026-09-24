## Phase 2 is coming together.

The development of Phase 2 of www.allthingspg.org is under way.  As a software engineering project, the first task is to document the changes before developing to code.  This allows for stateholders to understand the planned changes and have input as to how the updated website will function.  Key to phase 2 is

- Clarify the mission of All Things PG and the goals of the website
- Identify the audience, who will be using the website and why
- identify new Phase 2 features that will support the mission and purpose of ATPG website
- build a well designed and powerful database that implements the new features
- enhance the user experience to make it easier to learn about PG and find what you're looking for
- collect data to support fundraising, sending emails, newsletters
- provide help and contact support to users of the website
- build a prototype to prove some of the new design concepts (Proof of Concept - POC)

Where to begin?

1) Start by learning about DCMS - a design concept for curating dynamic content and associating content towith dynamic menu items.  

2) Learn about the User Experience, how each type of visitor (Patients, Caregivers, Providers, Pharmaceutical Reps) can have a different user experience through the concept of a Portal.  For example:: A doctor wanting to know about treatment may want more detailed information than a patient or a caregiver.  A caregiver wants to know their role, not the doctors role.


### Documents

- [Executive Summary]({{ '/docs/executive-summary.html' | relative_url }})
- [Portal Experience]({{ '/docs/portal-experience.html' | relative_url }})
- [Curating Content]({{ '/docs/curating-content.html' | relative_url }})
- [Managing Tiles]({{ '/docs/managing-tiles.html' | relative_url }})

<div class="gate-overlay" id="site-gate">
  <div class="gate-card">
    <h2>Administrator access</h2>
    <p>Enter the site-wide access code to view pgfacts.org.</p>
    <input id="gate-code" type="password" placeholder="Access code" autocomplete="off">
    <button type="button" id="gate-submit">Enter site</button>
    <div class="gate-note">Simple gate for now; not a full login system.</div>
  </div>
</div>

<script>
  (function () {
    var gateKey = "pgfacts-admin-unlocked";
    var gateCode = atob("QVRQRw==");
    var allowBlankDevelopment = {{ site.gateway.allow_blank_development | default: false | jsonify }};
    var gate = document.getElementById("site-gate");
    var input = document.getElementById("gate-code");
    var submit = document.getElementById("gate-submit");

    function unlock() {
      sessionStorage.setItem(gateKey, "true");
      gate.style.display = "none";
    }

    if (sessionStorage.getItem(gateKey) === "true") {
      gate.style.display = "none";
      return;
    }

    submit.addEventListener("click", function () {
      if ((allowBlankDevelopment && input.value === "") || input.value === gateCode) {
        unlock();
      } else {
        input.value = "";
        input.focus();
        alert("Incorrect access code.");
      }
    });

    input.addEventListener("keydown", function (event) {
      if (event.key === "Enter") {
        submit.click();
      }
    });
  })();
</script>
