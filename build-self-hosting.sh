ete pipeline: Sailfin → Bootstrap → Self-Hosted → Native Code"
    echo ""
    echo -e "${YELLOW}Build artifacts in $BUILD_DIR:${NC}"
    ls -la "$BUILD_DIR" 2>/dev/null || echo "No artifacts directory"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "• Test the standalone compiler: ${BLUE}$BUILD_DIR/sfn --help${NC}"
    echo "• Explore examples: ${BLUE}ls $EXAMPLES_DIR${NC}"
    echo "• Read the language spec: ${BLUE}cat $REPO_ROOT/docs/spec.md${NC}"
    echo ""
    echo -e "${GREEN}🚀 Sailfin is now a fully self-hosting programming language!${NC}"
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Sailfin Build System"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  build          Build Sailfin compiler from source (default)"
        echo "  test           Run compiler tests and examples"
        echo "  clean          Clean build directory"
        echo "  examples       Test all examples only"
        echo "  compiler       Build compiler only (no tests)"
        echo ""
        exit 0
    ;;
    clean)
        print_header
        clean_build
        exit 0
    ;;
    test)
        print_header
        test_compiler
        test_examples
        exit 0
    ;;
    examples)
        print_header
        test_examples
        exit 0
    ;;
    compiler)
        print_header
        build_compiler
        exit 0
    ;;
    build|"")
        # Default: full build pipeline
    ;;
    *)
        log_error "Unknown command: $1"
        echo "Use --help for usage information"
        exit 1
    ;;
esac

# Main build pipeline
main() {
    print_header
    
    log_info "Starting Sailfin build pipeline..."
    echo ""
    
    # Step 1: Clean
    clean_build
    echo ""
    
    # Step 2: Build compiler
    build_compiler
    echo ""
    
    # Step 3: Test compiler
    test_compiler
    echo ""
    
    # Step 4: Test examples
    test_examples
    echo ""
    
    # Step 5: Success
    log_success "🎉 Sailfin build completed successfully!"
    echo ""
    echo -e "${YELLOW}Built artifacts:${NC}"
    ls -la "$BUILD_DIR"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "• Test the compiler: ${BLUE}python $BUILD_DIR/sailfin_compiler.py examples/basics/hello-world.sfn${NC}"
    echo "• Explore examples: ${BLUE}ls $EXAMPLES_DIR${NC}"
    echo "• Run tests: ${BLUE}./build.sh test${NC}"
}

# Run main build pipeline
main "$@"

