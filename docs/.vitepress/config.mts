import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Blog",
  description: "A VitePress Site",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/guide/getting_started' },
      { text: 'Docs', link: '/dev/overview' },
      { text: 'Ex', link: '/markdown-examples'}
    ],

    sidebar: {
      '/guide/': [
        {
          text: 'Getting Started',
          collapsed: true,
          items: [
            { text: 'Introduction', link: '/guide/getting_started'},
          ]
        },
        {
          text: 'Usig the Blog',
          collapsed: true,
          items: [
            { text: 'Reding & Commenting', link: '/guide/reading_commenting'},
            { text: 'Your Account', link: '/guide/account'},
          ]
        },
        {
          text: 'Admin Panel',
          collapsed: true,
          items: [
            { text: 'Users', link: '/guide/users'},
            { text: 'Posts & PDFs', link: '/guide/posts'},
            { text: 'Statistics', link: '/guide/statistics'},
          ]
        },
      ],
      '/dev/': [
          {
            text: 'Overview',
            collapsed: true,
            items: [
              { text: 'Architecture', link: '/dev/overview'},
              { text: 'Setup', link: '/dev/setup'},
            ] 
          },
          {
            text: 'Backend',
            collapsed: true,
            items: [
              { text: 'Models', link: '/dev/models'},
              { text: 'Authentication', link: '/dev/authentication'},
              { text: 'Background Jobs', link: '/dev/background'},
            ]
          },
          {
            text: 'Frontend',
            collapsed: true,
            items: [
              { text: 'Project Structure', link: '/dev/structure'},
              { text: 'Routing', link: '/dev/routing'},
            ]
          },
          {
            text: 'Reference',
            collapsed: true,
            items: [
              { text: 'API Reference', link: '/dev/api' },
              { text: 'Deployment', link: '/dev/deployment' },
            ]
          }
        ]
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/vollarai/Blog' }
    ]
  }
})
