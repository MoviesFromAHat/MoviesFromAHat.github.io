module.exports = {
  paths: {
    public: "docs"
  },
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/style.css"
    }
  },
  plugins: {
    elm: {
      "exposed-modules": ["Main"],
      renderErrors: true,
      parameters: ["--debug", "--yes", "--warn"]
    },
    elmCss: {
      sourcePath: "app/css/Stylesheets.elm",
      outputDir: "app/assets"
    }
  },
  overrides: {
    production: {
      plugins: {
        elm: {
          renderErrors: false,
          parameters: ["--yes", "--warn"]
        }
      }
    }
  }
};
