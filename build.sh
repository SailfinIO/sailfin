OW}Compiler available at:${NC} $BUILD_DIR/sfn"
    echo -e "${YELLOW}Release package:${NC} $BUILD_DIR/sailfin-$(uname -s)-$(uname -m).tar.gz"
    echo ""
    echo -e "${GREEN}🚀 Sailfin is now fully self-hosting!${NC}"
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "Sailfin Self-Hosting Build System"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  build          Build Sailfin compiler and create release (default)"
        echo "  compiler       Build compiler only"
        echo "  test           Test compiler and examples"
        echo "  examples       Test all examples only"
        echo "  release        Create release package"
        echo "  clean          Clean build directory"
        echo ""
        exit 0
    ;;
    clean)
        print_header
        clean_build
        exit 0
    ;;
    compiler)
        print_header
        build_compiler
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
    release)
        print_header
        create_release
        exit 0
    ;;
    build|"")
        print_header
        main_build
        exit 0
    ;;
    *)
        log_error "Unknown command: $1"
        echo "Use --help for usage information"
        exit 1
    ;;
esac
