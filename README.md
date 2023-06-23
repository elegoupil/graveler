# {graveler}

> Build standardized, branded, modular dashboards to deploy on [UNHCR Rstudio Connect Server](http://rstudio.unhcr.org)

## Overview

This [{graveler} fork](https://github.com/ghcarlalan/graveler) is an __Rstudio Project Template__ and a wrapper for [{golem}](https://engineering-shiny.org/), [{shinyDashboard}](https://rstudio.github.io/shinydashboard/index.html) and [{unhcrshiny}](https://edouard-legoupil.github.io/unhcrshiny/) packages. 

At a high level, {golem} turns your shiny dashboards into a package framework and allows you to build and deploy them almost exactly as you would for an R package. This allows for better documentation, testing, robustness, etc. {graveler} abstracts away its technical side and set defaults for the development workflow of UNHCR dashboards.

You shall then be able to make a working dashboard in a few minutes!

## Dashboard in Shiny

Developing dashboards in shiny, rather than with a _"point and click"_  software, requires some familiarity with R programming but also comes with numerous advantages: 

 *  __Customizability within standards__: Shiny offers a high level of flexibility and customization, allowing you to design interactive dashboards with tailored visualizations, layouts, and user interfaces (including for the instance [humanitarian icons](https://fontawesome.com/icons/categories/humanitarian)). This comes also with amazing plotting capacity leveraging [ggplot2](https://ggplot2.tidyverse.org/). At the same time, as soon as the standard css (with [{unhcrshiny}](https://edouard-legoupil.github.io/unhcrshiny/)) is used, the look and feel will remain fully consistent.
 
 *  __Seamless Integration with R__: Shiny allows you to leverage the power and flexibility of the R language and its extensive ecosystem of packages for data analysis, visualization, and statistical modeling.

  *  __Responsiveness on mobile devices__: Shiny Dashboard are built per default with bootstrap, allowing for User Interface Responsiveness, meaning the resulting product will be legible on smartphones for senior managers in a hurry.
 
 *  __Advanced Analytics__: With R's extensive statistical capabilities, Shiny enables the integration of complex statistical models and advanced analytics directly into your dashboard.
 
 *  __Reproducibility and Transparency__: Since Shiny dashboards are built using R code, they are inherently reproducible and transparent, making it easier to share and validate analysis methods and results.
 
  *  __Publication__: UNHCR has already invested in a [Rstudio Connect server](http://rstudio.unhr.org) infrastructure.
 
 *  __Open-Source Community__: Shiny benefits from a large and active open-source community, which provides a wealth of resources, packages, and support.

## Why Bother with {graveler}?

As any development team grows larger, it is important to standardize code to avoid the dreaded event in which you are handed a project that is coded so differently from your usual workflow that you either have to spend hours refactoring and / or rebuilding from scratch. Additionally, {shiny} itself can be complicated to spin up at times for developers who are not familiar with its syntax. 

__{graveler} allows you to create standard, scalable and documented code so you can focus on actual dashboard element creation instead of spending time getting the various back-end pieces to talk to each other.__

> Note that this package is not like {shinyWidgets} or other shiny element packages. This is a __dashboard skeleton creator__ that allows you and your team to all start from the same page (some might say fluidPage) so your dashboards all have the same feel, layout, and backend creation.

## Get Started

### Package Installation

If you are on windows, you will need to install [Rtools](https://cran.r-project.org/bin/windows/Rtools/) on the top of [R](https://cran.rstudio.com/) [Rstudio](https://posit.co/download/rstudio-desktop/)

Then you can paste the following to install the package:

```
install.packages("pak")
pak::pkg_install("edouard-legoupil/graveler")
```

Once the package is installed on your Rstudio, follow the steps below:

### Project Creation

To create a {graveler} dashboard:

1.  Click `New Project`

2.  Select `New Directory`

3.  Select `using UNHCR Shiny Dashboard Template`

<img src="man/figures/wizard1.png" width="389"/>

4.  Fill out the form, ensuring that the `Directory Name` and `Pkg Name` both match and are written in camelCase (failing to do so will break your dashboard immediately)

<img src="man/figures/wizard.png" width="389"/>

5.  Make sure to set the proper sub directory within your computer file system

6.  Click `Create Project`


This will make a new directory on your machine with the following structure:

```
   .
   ├── .Rbuildignore # ignores systems files not needed for builds
   ├── DESCRIPTION # where libraries are installed for your package
   ├── dev/
   │   ├── 01_dev.R # package dependencies and system file creations
   │   └──  run_dev.R # build, document, and run the shiny dashboard
   ├── foo.Rproj
   ├── inst/
   │   └── app/
   │       └── www/ # standard shiny extra file subfolder
   │           └── favicon.ico # unhcr favicon
   ├── man/ # .Rd system files for functions generated by R
   └── R/
       ├── apex_libraries.R # necessary libraries your dashboard loads
       ├── app_server.R # callModules server side here
       ├── app_ui.R # combines header, sidebar, body files
       ├── body.R # organizes UI layouts - call in modules ui side there
       ├── golem_add_external_resources.R # allows usage of www/ folder
       ├── header.R # display name and other shinydashboardPlus features
       ├── mod_home.R  # first module for your splash page            
       ├── mod_home_fct_display.R # functions related to your home module 
       └── sidebar.R # tabs and their icons - call in modules menu there
```

### Initialization of the app

When you load up the new project, you will have two files open: `01_dev.R` and `run_dev`.

#### 01_dev

The first file sets up the dependencies for deployment. If you check the `DESCRIPTION` file, it will have no imports on initialization. When you run this file, it attaches all of your libraries to the package so that the server you publish to can know what to install and run.

These include the libraries you need to run your dashboard, a golem.config system file, an app.R file to deploy on RStudio Connect, and a manifest file to use git backed content within RStudio Connect. You can adjust these to fit your workflow.

At the end of the file, you will navigate to the run_dev.R file.

![](man/figures/01_dev.png)

#### run_dev

Once your dependencies and system files are in place, you can run all code in the `run_dev.R` file. 


![](man/figures/run_dev.png)



This should successfully run and load your (currently empty) shiny dashboard! 

> **Note:** When you run the line `run_dev.R`, you will be prompted in your console to create a golem-config.yml file. Enter 1 when prompted to create the necessary backend files required for {golem} to run your dashboard package.


In the span of a minute you have already made a reproducible and fully functional framework!

<img src="man/figures/empty.png" width="502"/>

If you are familiar with building R packages, this file is the equivalent of running the `Install and Restart` option: it creates your `NAMESPACE`, documents .Rd files, and temporarily installs it locally.

> If you need to add a new library, simply add into the `01_dev.R` file and the `apex_libraries.R` file and run it again. If you need to remove a library, you will need to edit the `DESCRIPTION` file manually.



### Modularization

If you are unfamiliar, modularization splits your dashboard into *n* files where *n* is the number of sidebar tabs / modules you want to make that each have their own UI and server namespaces. This allows you to independently load each module's code (if one breaks, the rest will still work) and reuse IDs for UI elements (you can give different plotOuputs a generic name like "chart" across two different modules).

By default the template comes with an initial `home` module where the first tab with the home page is included.

#### Creation

When inside a `{graveler}` project, running the function `level_up(name = "foo")` will add a new module - called `"foo"` - to your dashboard as well as a `fct` file, which is how {golem} [suggests you functionalize your code](https://engineering-shiny.org/build-app-golem.html?q=fct#submodules-and-utility-functions):

```
   .
   ├── R/
   │   ├── apex_libraries.R
   │   ├── app_config.R
   │   ├── app_server.R
   │   ├── app_ui.R
   │   ├── body.R
   │   ├── golem_add_external_resources.R
   │   ├── header.R
   │   ├── mod_foo.R                    <<<<< HERE
   │   ├── mod_foo_fct_display.R        <<<<< HERE
   │   ├── mod_home.R            
   │   ├── mod_home_fct_display.R  
   │   ├── run_app.R
   │   └── sidebar.R
   ├── man/
   ├── inst/
   ├── dev/
   ├── DESCRIPTION
   ├── foo.Rproj
   ├── .Rbuildignore
   └── NAMESPACE
```

![](man/figures/blank_mod.png)

You place your UI and server code in the `mod` file, and then you abstract away repeatable data manipulation or plotting functions inside the `fct` file. You can see this in the `unhcrboard` example dashboard files:

![](man/figures/fct_display.png)

In general, this helps keep your module code short and tidy, and allows you to put documentation for your functions just like a package.

#### Connection between modules and dashboard

`level_up` might create your module, but you still need to tell your dashboard to include and run this module. To do so, there are three lines at the bottom you copy and paste into their appropriate files: body.R, app_server.R, and sidebar.R (uncommentted, of course).

The body and sidebar lines need to be separated with commas if you have multiple modules, but the app_server will be individual lines like so:

![](man/figures/mod_copy.png)

Once that is done, your modules should appear on the left. All that is left to do is to insert your actual dashboard elements.


#### Communication between modules

Typically communication between modules will be required if you want to use filters across modules.

This imply to set a specific object `reactivalues` that will be consumed by all your modules.

### Customization

Additional or custom libraries would be edited in the dev/01_dev.R and R/apex_libraries.R files as examples.

The implementation of the brand within your plots should be done with [unhcrthemes](https://vidonne.github.io/unhcrthemes/). 


## Deployment

Once the `run_dev.R` file runs and your dashboard is error free, you can go for deployment. 

Get in touch with __UNHCR Global Data Service__ to obtain a Rstudio Connect license.

For publication, you have two main options. 

### Option 1: Publish via Button


In order to deploy your application, the basic file have been created. 

Run the `app.R` file to launch your application locally and then click on the blue: "`publish button`"" in the top right.
![](man/figures/deploy.png)

 It will gather your dependencies, ensure the server has them installed, and then your dashboard will be viewable on RStudio Connect.
[More info on deployement here](https://data-viz.it.wisc.edu/__docs__/admin/appendix/deployment-guide/)

### Option 2:  Publish via Github

As a general approach, it is a good practice to keep a copy of your dashboard in github.

> Be cautious with password and token - do not upload this in github. Password and token should rather be called as envrionement variables and set up separately after deployement in rstudio Connect


While more involved then simply clicking a button, git backed content will ensure your published works will align with your team's codebase and allow others to collaborate easier. Earlier, we made a `manifest.json` file at the end of the `01_dev.R` file. This creates an "image" that RStudio looks for and reproduces from github directly.

To publish for the first time, you push your code to whichever repo and branch on github, then in RStudio Connect you click its blue, publish button. You then navigate to the repo and branch you just pushed to, find the manifest file. Just like before, it will gather your dependencies from the manifest, ensure the server has them installed, and then your dashboard will be viewable on RStudio Connect.

To republish changes in the future, you simply merge your code to github and the file will automatically reflect those changes when it sees them.


## Learn from Examples

Before you start, scope well your project. Dashboard are not always the best way to present information. Think of a simple comparison: when you drive your car, your dashboard is giving you the key information you need so that you can make a decision based on a knowledge you already have (_i.e., you already know how to interpret the information of the various gauges_). If you rather try to present information, in order to build knowledge, then creating a notebook with narrative to explain the data will be likely more effective.

You can see check typical examples of dashboard within the package: one for protection monitoring and one for response monitoring. They were prepared with dummy data for the famous country called [Ruritania](Ruritania)

As a _rule of thumb_, a good dashboard should remain simple to be effective (aka not more than 7 charts, and not more than 7 categories by charts). 

To help in the design process, the package includes examples of typical charts that can be assembled together both for Response and Protection Monitoring. The file structure is located in the [examples folder](https://github.com/Edouard-Legoupil/graveler/tree/main/inst/examples).

##### Example 1: Protection Monitoring

Typically the content of a Protection Monitoring Dashboard allows to quickly identify the situation of basic rights in order to pilot the activities on the ground. It should complement (_and not replace!_) an in-depth protection analysis based on the protection risk equation. It would include: 

 1.  __Exposure: Vulnerable Populations:__ Treemap displaying the percentage of different vulnerable populations (e.g., children, women, elderly, disabled) affected by protection concerns. 

 2.  __Thread: Incident Types and Frequency:__ Line chart illustrating the trend in the frequency of of different types of protection incidents (e.g., violence, exploitation, discrimination) over time, allowing for identification of spikes or patterns.

 3.  __Coping: Response Coverage:__ Donut chart showcasing the coverage and reach of protection interventions by different implementing organizations or sectors.

 4.  __Compliance with Protection Standards:__ Radar chart comparing the adherence to different protection standards (e.g., human rights principles, international humanitarian law) by various implementing actors or sectors.

 5.  __Protection Advocacy Challenges:__ Gantt chart depicting the timeline of identified advocacy and the status of efforts to address them, allowing for tracking progress and resolution.

 6.  __Key Performance Indicators (KPIs):__  Highlighted numbers specific KPIs related to the protection response (e.g., number of cases resolved, number of survivors accessing support services). 

 7.  __Geographic Distribution:__    Choropleth map presenting the spatial distribution of protection incidents, vulnerability, or response activities, allowing for visual identification of hotspots or areas in need.

```
graveler::_example_protection()
```

<img src="man/figures/empty.png" width="551"/>

##### Example 2: Response Monitoring


Typically the content of a Response Monitoring Dashboard allows to ensure that the right activities are done right. It would typically include: 

 1.  __Needs Assessment and Population:__  Population pyramid illustrating the demographic composition of the affected population (e.g., age, gender) including specific needs to inform targeted response planning.

 2.  __Resources Allocation:__ Heatmap representing the  allocation of resources (e.g., funding, personnel, supplies) by response activities, allowing for visual identification of areas with high or low response coverage.

 3.  __Key Performance Indicators (KPIs):__ Gauge chart indicating the achievement of predetermined targets or benchmarks for the response activities.

 4.  __Funding Management:__  Staked Bar chart comparing the planned versus actual resource allocations to identify discrepancies or gaps in resource management.

 5.  __Coordination and Partnership:__  Sankey diagram showing the collaboration and partnerships among different response organizations or clusters, measuring the frequency of coordination meetings or joint planning efforts

 6.  __Impact and Outcome:__  Bubble chart showcasing the correlation between response interventions and key outcomes or impact indicators (e.g., improved health indicators, increased access to education).

 7.  __Alert:__   Area chart providing real-time updates on key indicators, allowing for immediate identification of emerging trends or shifts in the humanitarian situation (for instance average assistance enrollment processing time).
 

```
graveler::_example_response()
```

<img src="man/figures/empty.png" width="551"/>




## .. Register your dashbaord!

On UNHCR Data Portal: [https://data.unhcr.org/en/dataviz](https://data.unhcr.org/en/dataviz)
