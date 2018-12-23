package com.pwk.tools;

import com.pwk.lucene.ProductLuceneService;
import com.pwk.service.*;

public class Engine {
    public static BrandService brandService;
    public static ProductService productService;
    public static HotSaleService hotSaleService;
    public static IndexProductService indexProductService;
    public static FAQService faqService;
    public static UserService userService;
    public static ShoppingCartService shoppingCartService;
    public static AboutUsService aboutUsService;
    public static OrderService orderService;
    public static AdminService adminService;
    public static ColorService colorService;
    public static IndexInfoService indexInfoService;
    public static IndexPicService indexPicService;
    public static VideoService videoService;
    public static LocationService locationService;
    public static PaymentDetailService paymentDetailService;
    public static SaleAnalysisService saleAnalysisService;
    public static ImageService imageService;
    public static TransactionHistoryService transactionHistoryService;
    public static PV_Service pv_service;
    public static AttributeService attributeService;
    public static ParameterService parameterService;
    public static CategoryService categoryService;
    public static ProductLuceneService productLuceneService;

    public void setBrandService(BrandService brandService) {
        Engine.brandService = brandService;
    }

    public void setProductService(ProductService productService) {
        Engine.productService = productService;
    }

    public void setHotSaleService(HotSaleService hotSaleService) {
        Engine.hotSaleService = hotSaleService;
    }

    public void setIndexProductService(IndexProductService indexProductService) {
        Engine.indexProductService = indexProductService;
    }

    public void setFaqService(FAQService faqService) {
        Engine.faqService = faqService;
    }

    public void setUserService(UserService userService) {
        Engine.userService = userService;
    }

    public void setShoppingCartService(ShoppingCartService shoppingCartService) {
        Engine.shoppingCartService = shoppingCartService;
    }

    public void setAboutUsService(AboutUsService aboutUsService) {
        Engine.aboutUsService = aboutUsService;
    }

    public void setOrderService(OrderService orderService) {
        Engine.orderService = orderService;
    }

    public void setAdminService(AdminService adminService) {
        Engine.adminService = adminService;
    }

    public void setColorService(ColorService colorService) {
        Engine.colorService = colorService;
    }

    public void setIndexInfoService(IndexInfoService indexInfoService) {
        Engine.indexInfoService = indexInfoService;
    }

    public void setIndexPicService(IndexPicService indexPicService) {
        Engine.indexPicService = indexPicService;
    }

    public void setVideoService(VideoService videoService) {
        Engine.videoService = videoService;
    }

    public void setLocationService(LocationService locationService) {
        Engine.locationService = locationService;
    }

    public  void setPaymentDetailService(PaymentDetailService paymentDetailService) {
        Engine.paymentDetailService = paymentDetailService;
    }

    public void setSaleAnalysisService(SaleAnalysisService saleAnalysisService) {
        Engine.saleAnalysisService = saleAnalysisService;
    }

    public void setImageService(ImageService imageService) {
        Engine.imageService = imageService;
    }

    public void setTransactionHistoryService(TransactionHistoryService transactionHistoryService) {
        Engine.transactionHistoryService = transactionHistoryService;
    }

    public void setPv_service(PV_Service pv_service) {
        Engine.pv_service = pv_service;
    }

    public void setAttributeService(AttributeService attributeService) {
        Engine.attributeService = attributeService;
    }

    public void setParameterService(ParameterService parameterService) {
        Engine.parameterService = parameterService;
    }

    public void setCategoryService(CategoryService categoryService) {
        Engine.categoryService = categoryService;
    }

    public void setProductLuceneService(ProductLuceneService productLuceneService) {
        Engine.productLuceneService = productLuceneService;
    }
}
