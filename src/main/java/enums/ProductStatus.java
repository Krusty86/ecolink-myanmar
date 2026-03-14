package enums;

public enum ProductStatus {
	DRAFT,	//The supplier is still uploading photos or descriptions. It is not visible to buyers yet
	ACTIVE,	//The product is live and can be added to a cart
	OUT_OF_STOCK, //Visible to buyers, but the "Add to Cart" button is disabled
	ARCHIVED	//The product is no longer sold. It stays in the database for history but disappears from the shop
}
