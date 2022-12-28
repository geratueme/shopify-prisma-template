-- CreateTable
CREATE TABLE "ShopSession" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL,
    "accessToken" TEXT NOT NULL,
    "scope" TEXT NOT NULL,
    "expires" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "ShopOnlineAccessInfo" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "expires_in" INTEGER NOT NULL,
    "associated_user_scope" TEXT NOT NULL,
    "session" TEXT NOT NULL,
    "account_number" INTEGER NOT NULL,
    "userEmail" TEXT NOT NULL,
    "shopSessionId" TEXT NOT NULL,
    CONSTRAINT "ShopOnlineAccessInfo_userEmail_fkey" FOREIGN KEY ("userEmail") REFERENCES "User" ("email") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ShopOnlineAccessInfo_shopSessionId_fkey" FOREIGN KEY ("shopSessionId") REFERENCES "ShopSession" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "first_name" TEXT,
    "last_name" TEXT,
    "email" TEXT NOT NULL,
    "account_owner" BOOLEAN,
    "locale" TEXT,
    "collaborator" BOOLEAN,
    "email_verified" BOOLEAN,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "ShopOnlineAccessInfo_userEmail_key" ON "ShopOnlineAccessInfo"("userEmail");

-- CreateIndex
CREATE UNIQUE INDEX "ShopOnlineAccessInfo_shopSessionId_key" ON "ShopOnlineAccessInfo"("shopSessionId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
