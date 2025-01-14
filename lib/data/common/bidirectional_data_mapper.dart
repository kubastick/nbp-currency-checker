abstract interface class BiDirectionalDataMapper<DOMAIN_OBJECT, DATA_TRANSFER_OBJECT> {
  DATA_TRANSFER_OBJECT fromDomain(DOMAIN_OBJECT data);

  DOMAIN_OBJECT toDomain(DATA_TRANSFER_OBJECT data);
}
