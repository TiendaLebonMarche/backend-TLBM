import { loadEnv, defineConfig } from '@medusajs/framework/utils'

loadEnv(process.env.NODE_ENV || 'development', process.cwd())

export default defineConfig({
  projectConfig: {
    databaseUrl: process.env.DATABASE_URL as string,
    redisUrl: process.env.REDIS_URL as string,
    http: {
      storeCors: (process.env.STORE_CORS || 'http://localhost:8000') as string,
      adminCors: (process.env.ADMIN_CORS || 'http://localhost:9000') as string,
      authCors: (process.env.AUTH_CORS || 'http://localhost:9000') as string,
      jwtSecret: (process.env.JWT_SECRET || 'supersecret') as string,
      cookieSecret: (process.env.COOKIE_SECRET || 'supersecret') as string,
    },
    workerMode: (process.env.MEDUSA_WORKER_MODE || 'shared') as 'shared' | 'worker' | 'server',
  },
  modules: [
    {
      resolve: '@medusajs/medusa/cache-redis',
      options: {
        redisUrl: process.env.REDIS_URL as string,
      },
    },
    {
      resolve: '@medusajs/medusa/event-bus-redis',
      options: {
        redisUrl: process.env.REDIS_URL as string,
      },
    },
    {
      resolve: '@medusajs/medusa/workflow-engine-redis',
      options: {
        redis: {
          url: process.env.REDIS_URL as string,
        },
      },
    },
  ],
})