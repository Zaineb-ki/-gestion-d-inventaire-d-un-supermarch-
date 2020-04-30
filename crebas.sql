/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 16                          */
/* Created on:     27/04/2020 00:36:26                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_PRODUCT_ASSOCIATI_PROVIDER') then
    alter table Product
       delete foreign key FK_PRODUCT_ASSOCIATI_PROVIDER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRODUCT_ASSOCIATI_RAY') then
    alter table Product
       delete foreign key FK_PRODUCT_ASSOCIATI_RAY
end if;

drop index if exists Product.ASSOCIATION2_FK;

drop index if exists Product.ASSOCIATION1_FK;

drop index if exists Product.PRODUCT_PK;

drop table if exists Product;

drop index if exists Provider.PROVIDER_PK;

drop table if exists Provider;

drop index if exists Ray.RAY_PK;

drop table if exists Ray;

/*==============================================================*/
/* Table: Product                                               */
/*==============================================================*/
create table Product 
(
   idProvider           integer                        not null,
   idProduct            integer                        not null,
   idRay                integer                        not null,
   "reference"          varchar(254)                   null,
   designation          varchar(254)                   null,
   constraint PK_PRODUCT primary key clustered (idProvider, idProduct)
);

/*==============================================================*/
/* Index: PRODUCT_PK                                            */
/*==============================================================*/
create unique clustered index PRODUCT_PK on Product (
idProvider ASC,
idProduct ASC
);

/*==============================================================*/
/* Index: ASSOCIATION1_FK                                       */
/*==============================================================*/
create index ASSOCIATION1_FK on Product (
idProvider ASC
);

/*==============================================================*/
/* Index: ASSOCIATION2_FK                                       */
/*==============================================================*/
create index ASSOCIATION2_FK on Product (
idRay ASC
);

/*==============================================================*/
/* Table: Provider                                              */
/*==============================================================*/
create table Provider 
(
   idProvider           integer                        not null,
   name                 varchar(254)                   null,
   emaiL                varchar(254)                   null,
   phone                varchar(254)                   null,
   constraint PK_PROVIDER primary key clustered (idProvider)
);

/*==============================================================*/
/* Index: PROVIDER_PK                                           */
/*==============================================================*/
create unique clustered index PROVIDER_PK on Provider (
idProvider ASC
);

/*==============================================================*/
/* Table: Ray                                                   */
/*==============================================================*/
create table Ray 
(
   idRay                integer                        not null,
   codeRef              varchar(254)                   null,
   constraint PK_RAY primary key clustered (idRay)
);

/*==============================================================*/
/* Index: RAY_PK                                                */
/*==============================================================*/
create unique clustered index RAY_PK on Ray (
idRay ASC
);

alter table Product
   add constraint FK_PRODUCT_ASSOCIATI_PROVIDER foreign key (idProvider)
      references Provider (idProvider)
      on update restrict
      on delete restrict;

alter table Product
   add constraint FK_PRODUCT_ASSOCIATI_RAY foreign key (idRay)
      references Ray (idRay)
      on update restrict
      on delete restrict;

