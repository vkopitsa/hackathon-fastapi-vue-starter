module.exports = {
  // Fix Vuex-typescript in prod: https://github.com/istrib/vuex-typescript/issues/13#issuecomment-409869231
  configureWebpack: (config) => {
    if (process.env.NODE_ENV === 'production') {
      config.optimization.minimizer[0].options.terserOptions = Object.assign(
        {},
        config.optimization.minimizer[0].options.terserOptions,
        {
          ecma: 5,
          compress: {
            keep_fnames: true,
          },
          warnings: false,
          mangle: {
            keep_fnames: true,
          },
        },
      );
    }
  },
  chainWebpack: config => {
    config.module
      .rule('vue')
      .use('vue-loader')
      .loader('vue-loader')
      .tap(options => Object.assign(options, {
        transformAssetUrls: {
          'v-img': ['src', 'lazy-src'],
          'v-card': 'src',
          'v-card-media': 'src',
          'v-responsive': 'src',
        }
      }));
  },
  devServer: {
    hot: true,
    proxy: {
      '^/api': {
        target: process.env.VUE_APP_PROXY,
      },
    },
    before: function(app, server, compiler) {
      app.use((req, res, next) => {
        if (req.url.startsWith('/api') && process.env.VUE_APP_PROXY_LOG == "true") {
          console.log('---');
          console.log('Request URL:', req.url);
    
          if (req.method !== 'GET') {
            let bodyChunks = [];
    
            req.on('data', chunk => {
              bodyChunks.push(chunk);
            });
    
            req.on('end', () => {
              const body = Buffer.concat(bodyChunks).toString();
              console.log('Method:', req.method);
              // console.log('Headers:', req.headers); // Uncomment if headers are needed
              console.log('Body:', body);
            });
          }
        }
    
        next();
      });
    },
  },
}
