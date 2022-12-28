import { Session } from '@shopify/shopify-api';


export class PrismaSessionStorage {
  
  constructor(prismaClient) {
    this.prisma = prismaClient;
  }

  async storeSession(session) {
    try {
      const newSession = await this.prisma.shopSession.upsert({
        where: {
          id: session.id,
        },
        update: {
          state: session.state,
          isOnline: session.isOnline,
          accessToken: session.accessToken,
          scope: session.scope,
          onlineAccessInfo: JSON.stringify(session.onlineAccessInfo),
        },
        create: {
          id: session.id,
          shop: session.shop,
          state: session.state,
          isOnline: session.isOnline,
          accessToken: session.accessToken,
          scope: session.scope,
          expires: session.expires,
          onlineAccessInfo: JSON.stringify(session.onlineAccessInfo),
        },
      });
      console.log('Stored session', newSession);
      return false;
    } catch (err) {
      // error on save
      return false;
    }
  }

  async loadSession(id) {
    try {
      console.log(id)
      const session = await this.prisma.shopSession.findUnique({
        where: { id: id },
      })
      return new Session({
        shop: session.shop,
        state: session.state,
        isOnline: session.isOnline,
        scope: session.scope,
        expires: session.expires,
        accessToken: session.accessToken,
        onlineAccessInfo: JSON.parse(session.onlineAccessInfo),
      });
    } catch (err) {
      // error on read
      return undefined;
    }
  }

  async deleteSession(id) {
    try {
      const deleteSession = await this.prisma.shopSession.delete({
        where: { id },
      });
      console.log('Deleted session: ', deleteSession);
      return true;
    } catch (err) {
      // error on read
      return false;
    }
  }

  async deleteSessions(ids) {
    try {
      for (let i = 0; i < ids.length; i++) {
        const id = ids[i];
        const deleteSession = await this.prisma.shopSession.delete({
          where: { id },
        });
        console.log('Deleted session: ', deleteSession);
      }
      return true;
    } catch (err) {
      // error on read
      return false;
    }
  }

  async findSessionsByShop(shop) {
    try {
      const shopSessions = this.prisma.shopSession.findMany({
        where: { shop },
      });
      console.log('Sessions found', shopSessions)
      return shopSessions.map((s) => new Session(s));
    } catch (err) {
      // error on read
      return [];
    }
  }

}