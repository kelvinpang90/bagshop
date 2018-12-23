package com.pwk.lucene;

import com.pwk.entity.Image;
import com.pwk.entity.Product;
import com.pwk.service.ProductService;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.MultiFieldQueryParser;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.queryparser.simple.SimpleQueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.BytesRef;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-3-8
 * Time: 下午11:39
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class ProductLuceneServiceImpl implements ProductLuceneService {

    @Resource
    private ProductService productService;

    private IndexWriter indexWriter = null;

    private IndexReader indexReader = null;

    private IndexSearcher indexSearcher = null;

    private Path path = Paths.get("/opt/lucene");

    private Directory directory = null;

    private void initIndexWriter(IndexWriterConfig.OpenMode openMode) {
        try {
            directory = FSDirectory.open(path);

            IndexWriterConfig config = new IndexWriterConfig(new StandardAnalyzer());
            config.setOpenMode(openMode);
            indexWriter = new IndexWriter(directory, config);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void initIndexReader() {
        try {
            directory = FSDirectory.open(path);

            indexReader =  DirectoryReader.open(directory);
            indexSearcher = new IndexSearcher(indexReader);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void addProductIndex(Product product) {
        try {
            initIndexWriter(IndexWriterConfig.OpenMode.CREATE_OR_APPEND);
            indexWriter.addDocument(getDocument(product));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                indexWriter.close();
                directory.close();
            } catch (IOException e) {
                System.out.println("indexWriter close fail");
            }
        }
    }

    public void updateProductIndex(Product product) {
        try {
            initIndexWriter(IndexWriterConfig.OpenMode.CREATE_OR_APPEND);

            indexWriter.updateDocument(new Term("id",String.valueOf(product.getId())), getDocument(product));
            System.out.println("update index success");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                indexWriter.close();
                directory.close();
            } catch (IOException e) {
                System.out.println("indexWriter close fail");
            }
        }
    }

    @Override
    public void deleteProductIndex(int id) {
        try {
            initIndexWriter(IndexWriterConfig.OpenMode.CREATE_OR_APPEND);
            indexWriter.deleteDocuments(new Term("id",String.valueOf(id)));
            System.out.println("delete index success");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                indexWriter.close();
                directory.close();
            } catch (IOException e) {
                System.out.println("indexWriter close fail");
            }
        }
    }

    @Override
    public List<Product> searchByKeyword(String keyword,int page,int size,boolean status) {
        System.out.println("lucene searching：" + keyword);
        try {
            keyword = keyword+"*";
            BooleanQuery.Builder queryBuilder = new BooleanQuery.Builder();

//            Query query = new MultiFieldQueryParser(new String[]{"productName","brandName","categoryName"},new StandardAnalyzer()).parse(keyword);
            QueryParser queryParser = new QueryParser("productName",new StandardAnalyzer());
            Query query = queryParser.parse(keyword);
            queryBuilder.add(query, BooleanClause.Occur.MUST);
            Query query1 = new TermQuery(new Term("status","1"));
            queryBuilder.add(query1, BooleanClause.Occur.MUST);
            return search(queryBuilder.build(),page,size);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Product> searchByField_Precise(String fieldName, String keyword, int page, int size,boolean status) {
        try {
            BooleanQuery.Builder queryBuilder = new BooleanQuery.Builder();

            Query query = new QueryParser(fieldName,new StandardAnalyzer()).parse(keyword);
            queryBuilder.add(query, BooleanClause.Occur.MUST);
            if(!status){
                Query query1 = new TermQuery(new Term("status","1"));
                queryBuilder.add(query1, BooleanClause.Occur.MUST);
            }

            return search(queryBuilder.build(),page,size);
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Product> searchByField_Fuzzy(String fieldName, String keyword, int page, int size,boolean status) {
        try {
            BooleanQuery.Builder queryBuilder = new BooleanQuery.Builder();

            Query query = new SimpleQueryParser(new StandardAnalyzer(),fieldName).parse(keyword);
            queryBuilder.add(query, BooleanClause.Occur.MUST);
            if(!status){
                Query query1 = new TermQuery(new Term("status","1"));
                queryBuilder.add(query1, BooleanClause.Occur.MUST);
            }

            return search(queryBuilder.build(),page,size);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int getTotalByKeyword(String keyword,boolean status) {
        try {
            keyword = keyword+"*";
            BooleanQuery.Builder queryBuilder = new BooleanQuery.Builder();

//            Query query = new MultiFieldQueryParser(new String[]{"productName","brandName","categoryName"},new StandardAnalyzer()).parse(keyword);
            QueryParser queryParser = new QueryParser("productName",new StandardAnalyzer());
            Query query = queryParser.parse(keyword);
            queryBuilder.add(query, BooleanClause.Occur.MUST);
            if(!status){
                Query query1 = new TermQuery(new Term("status","1"));
                queryBuilder.add(query1, BooleanClause.Occur.MUST);
            }

            return searchTotal(queryBuilder.build());
        }catch (Exception e){
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int getTotalByField_Precise(String fieldName, String keyword, boolean status) {
        return 0;
    }

    @Override
    public int getTotalByField_Fuzzy(String fieldName, String keyword, boolean status) {
        return 0;
    }

    @Override
    public void addAllProductToIndex() {
        List<Product> products = productService.getAllProducts(true);
        for (int i = 0; i < products.size(); i++) {
            System.out.println("indexing: "+products.get(i).getName());
            addProductIndex(products.get(i));
        }
    }

    private List<Product> search(Query query,int page,int size) throws IOException {
        initIndexReader();
        List<Product> list = new ArrayList<Product>();
        int startIndex = (page -1) * size;

        SortField sortField = new SortField("updateDate", SortField.Type.STRING_VAL,true);
        Sort sort = new Sort(sortField);
        TopFieldCollector collector = TopFieldCollector.create(sort,9999,true,true,false);

        indexSearcher.search(query,collector);
        TopDocs topDocs = collector.topDocs(startIndex,size);
        System.out.println("Hits="+topDocs.totalHits);
        for(ScoreDoc scoreDoc:topDocs.scoreDocs){
            Document doc = indexSearcher.doc(scoreDoc.doc);
            System.out.println(doc.get("productName"));
            Product product = new Product();
            product.setId(Integer.valueOf(doc.get("id")));
            product.setName(doc.get("productName"));
            product.setPrice(Float.valueOf(doc.get("price")));

            Image image = new Image();
            image.setMiniPath(doc.get("imagePath"));
            Set<Image> images = new HashSet<Image>();
            images.add(image);
            product.setPicPath(images);
            list.add(product);
        }
        return list;
    }

    private int searchTotal(Query query) throws IOException {
        initIndexReader();
        TopDocs topDocs = indexSearcher.search(query,9999);
        System.out.println("total="+topDocs.totalHits);
        return topDocs.totalHits;
    }

    private Document getDocument(Product product) {
        Document document = new Document();
        document.add(new StringField("id", String.valueOf(product.getId()), Field.Store.YES));
        document.add(new StringField("productName", product.getName(), Field.Store.YES));
        Iterator<Image> imageIterator = product.getPicPath().iterator();
        document.add(new StringField("imagePath",(imageIterator.hasNext()?imageIterator.next().getMiniPath():""), Field.Store.YES));
        document.add(new StringField("categoryName",product.getCategory().getName(), Field.Store.YES));
        document.add(new IntField("categoryId",product.getCategory().getId(), Field.Store.YES));
        document.add(new StringField("brandName", product.getBrand().getBrandName(), Field.Store.YES));
        document.add(new IntField("brandId", product.getBrand().getId(), Field.Store.YES));
        document.add(new FloatField("price", product.getPrice(), Field.Store.YES));
        document.add(new StringField("status", product.getStatus(), Field.Store.YES));
        document.add(new StringField("createDate", product.getCreateDate().toString(), Field.Store.YES));
        document.add(new StringField("updateDate", product.getUpdateDate().toString(), Field.Store.YES));
        document.add(new SortedDocValuesField("updateDate", new BytesRef(product.getUpdateDate().toString())));
        document.add(new TextField("description", product.getDescription(), Field.Store.YES));
        return document;
    }
}
