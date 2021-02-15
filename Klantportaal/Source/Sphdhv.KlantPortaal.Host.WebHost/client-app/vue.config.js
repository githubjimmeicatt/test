﻿module.exports = {
      outputDir: 'dist',
      configureWebpack: {
        devtool: 'source-map'
    },
      chainWebpack: config => {
            config.module
                .rule('images')
                .use('url-loader')
                .loader('url-loader')
                .tap(options => {
                    options.limit = -1
                    return options
                })
          }
}